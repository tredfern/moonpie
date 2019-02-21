-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local box_model = require(BASE .. "box_model")

return function(props)
  return {
    box = box_model(),

    paint = function()
      if props.font then love.graphics.setFont(props.font) end
      if props.color then love.graphics.setColor(props.color) end

      love.graphics.print(props.text)
    end,

    layout = function(self)
      self.box.content.width, self.box.content.height =
        props.font:getWidth(props.text), props.font:getHeight()
    end
  }
end
