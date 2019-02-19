-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local box_model = require(BASE .. "box_model")

return function(component)
  return {
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
      local region = self.box:region()
      return region.left < mx and region.right > mx and region.top < my and region.bottom > my
    end,

    layout = function(self, parent)
      if parent then self.box.parent = parent.box end
      self.box.content.width = self.component.width or
        (parent.box.content.width
          - self.box.margin.left - self.box.margin.right
          - self.box.padding.left - self.box.padding.right
          - self.box.border.left - self.box.border.right)

      for _, v in pairs(self.children) do
        if v.layout then v:layout(self) end
      end

      local x, y = 0, 0
      local line_height, max_width = 0, 0

      for _, v in pairs(self.children) do
        if x > 0 and x + v.box:width() > self.box.content.width then
          x = 0
          y = y + line_height
          self.box.content.height = self.box.content.height + line_height
          line_height = 0
        end

        v.box.x, v.box.y = x, y
        x = x + v.box:width()
        line_height = math.max(v.box:height(), line_height)
        max_width = math.max(max_width, x)
      end
      self.box.content.height = self.box.content.height + line_height

      if self.component.display == "inline" then
        self.box.content.width = self.component.width or max_width
      end

      self.box.content.height = self.component.height or self.box.content.height
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
        love.graphics.setColor(e.background_color)
        love.graphics.rectangle("fill", 0, 0, self.box:background_size())
        love.graphics.pop()
      end
    end,
    draw_border = function(self, e)
      if e.border then
        love.graphics.push()
        love.graphics.translate(self.box:border_position())
        love.graphics.setColor(e.border_color)
        love.graphics.setLineWidth(e.border)
        love.graphics.rectangle("line", 0, 0, self.box:border_size())
        love.graphics.pop()
      end
    end,
    draw_click_region = function(self)
      local r = self.box:region()
      love.graphics.push()
      love.graphics.origin()
      love.graphics.setColor({1, 1, 1, 1 })
      love.graphics.setLineWidth(1)
      love.graphics.rectangle("line", r.left, r.top, r.right - r.left, r.bottom - r.top)
      love.graphics.pop()
    end
  }
end
