-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local box_model = require(BASE .. "box_model")

return function(element)
  return {
    element = element or {},
    box = box_model(),
    children = {},

    add = function(self, ...)
      for _, v in ipairs({...}) do
        self.children[#self.children + 1] = v
      end
    end,

    layout = function(self, parent)
      self.box.content.width = self.element.width or parent.width or parent.box.content.width

      for _, v in pairs(self.children) do
        if v.layout then v:layout(self) end
      end

      local x, y = self.box:content_position()
      local line_height, max_width = 0, 0

      for _, v in pairs(self.children) do
        if x > 0 and x + v.box.content.width > self.box.content.width then
          x = 0
          y = y + line_height
          line_height = 0
        end

        v.box.x, v.box.y = x, y
        x = x + v.box:width()
        line_height = math.max(v.box.content.height, line_height)
        max_width = math.max(max_width, x)
      end

      if self.element.display == "inline" then
        self.box.content.width = self.element.width or max_width
      end

      self.box.content.height = self.element.height or y + line_height
    end,

    paint = function(self)
      love.graphics.push()
      love.graphics.translate(self.box.x, self.box.y)
      if self.element.background then
        love.graphics.setColor(self.element.background.color)
        love.graphics.rectangle("fill", 0, 0, self.box.content.width, self.box.content.height)
      end

      for _, v in ipairs(self.children) do
        v:paint()
      end
      love.graphics.pop()
    end,
  }
end
