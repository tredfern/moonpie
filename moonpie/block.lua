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
      self.box.content.width = self.element.width or parent.width
      self.box.content.height = self.element.height

      for _, v in pairs(self.children) do
        if v.layout then v:layout(self) end
      end
    end,

    paint = function(self)
      if self.element.background then
        love.graphics.setColor(self.element.background.color)
        love.graphics.rectangle("fill", 0, 0, self.box.content.width, self.box.content.height)
      end

      for _, v in ipairs(self.children) do
        v:paint()
      end
    end,
  }
end
