-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.components.component"

Component("fps_counter", function()
  return {
    render = function()
      return {
        Component.text({
          text = "FPS: {{fps}}",
          fps = love.timer.getFPS()
        })
      }
    end
  }
end)
