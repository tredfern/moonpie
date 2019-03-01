-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local box_model = require("moonpie.box_model")
local colors = require("moonpie.colors")

return function(props)
  return {
    box = box_model(),

    paint = function(self)
      if props.color then love.graphics.setColor(colors(props.color)) end
      love.graphics.draw(self.text_image, 0, 0)
    end,

    layout = function(self, parent)
      local max_width = parent.box.content.width
      local f = props.font or love.graphics.getFont()
      self.text_image = love.graphics.newText(f)
      self.text_image:setf(props.text, max_width, "left")
      self.box.content.width, self.box.content.height = self.text_image:getDimensions()
    end
  }
end
