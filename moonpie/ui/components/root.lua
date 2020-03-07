-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"

Component("root", function()
  local rt = {
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight()
  }

  rt.resize = function(w, h)
    rt:update{ width = w, height = h }
  end

  local events = require "moonpie.events"
  events.window_resize:add(rt.resize)

  return rt
end)