-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local box_model = require(BASE .. "box_model")
local colors = require(BASE .. "colors")
local align = require(BASE .. "alignment")

return function(component)
  return setmetatable({
    component = component or {},
    box = box_model(component),
    children = {},

    add = function(self, ...)
      for _, v in ipairs({...}) do
        self.children[#self.children + 1] = v
      end
    end,

    hover = function(self)
      local mx, my = love.mouse.getPosition()
      return self.box:region():contains(mx, my)
    end,

    max_width = function(self, parent)
      return self.component.width or
        (parent.box.content.width
          - self.box.margin.left - self.box.margin.right
          - self.box.padding.left - self.box.padding.right
          - self.box.border.left - self.box.border.right)
    end,

    layout_children = function(self, width)
      local x, y = 0, 0
      local line_height, max_width, max_height = 0, 0, 0

      for _, v in pairs(self.children) do
        if v.layout then v:layout(self) end

        if x > 0 and x + v.box:width() > width then
          x = 0
          y = y + line_height
          max_height = max_height + line_height
          line_height = 0
        end

        local a = v.component and v.component.align or "left"
        v.box.x, v.box.y = align(a, x, width, v.box:width()), y
        x = v.box.x + v.box:width()
        line_height = math.max(v.box:height(), line_height)
        max_width = math.max(max_width, x)
      end

      max_height = max_height + line_height

      return max_width, max_height
    end,

    layout = function(self, parent)
      if parent then self.box.parent = parent.box end
      self.box.content.width = self:max_width(parent)
      self.box.content.height = 0

      local w, h = self:layout_children(self.box.content.width)

      if self.component.display == "inline" then
        self.box.content.width = self.component.width or w
      end
      self.box.content.height = self.component.height or h

      self.component.refresh_layout = nil
    end,

    refresh_needed = function(self)
      return self.component.refresh_layout
    end,

    paint = function(self)
      local e = self.component
      if self.component.hover and self:hover() then e = self.component.hover end

      love.graphics.push()
      love.graphics.translate(self.box.x, self.box.y)
      self:draw_border(e)
      self:draw_background(e)

      love.graphics.translate(self.box:content_position())

      for _, v in ipairs(self.children) do
        v:paint()
      end
      love.graphics.pop()
    end,
    draw_background = function(self, e)
      if e.background_color then
        love.graphics.push()
        love.graphics.translate(self.box:background_position())
        love.graphics.setColor(colors(e.background_color))
        local w, h = self.box:background_size()
        love.graphics.rectangle("fill", 0, 0, w, h,
          self.corner_radius_x or 0, self.corner_radius_y or 0)
        love.graphics.pop()
      end
    end,
    draw_border = function(self, e)
      if e.border then
        love.graphics.push()
        love.graphics.translate(self.box:border_position())
        love.graphics.setColor(colors(e.border_color))
        love.graphics.setLineWidth(e.border)
        local w, h = self.box:border_size()
        love.graphics.rectangle("line", 0, 0, w, h,
          self.corner_radius_x or 0, self.corner_radius_y or 0)
        love.graphics.pop()
      end
    end
  }, {
    __index = component
  })
end
