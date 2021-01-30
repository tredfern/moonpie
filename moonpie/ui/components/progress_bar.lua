-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local component = require "moonpie.ui.components.component"
local colors = require "moonpie.graphics.colors"

return component("progress_bar", function(props)
  return {
    maximum = props.maximum or 100,
    current = props.current or 0,

    draw_component = function(self)
      local completed = self.current / self.maximum
      love.graphics.setColor(colors(self.color))
      love.graphics.rectangle("fill", 0, 0, self.box.content.width * completed, self.box.content.height)
    end

  }
end)