-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local mouse = require "moonpie.mouse"
local render_engine = require "moonpie.ui.render_engine"
local input_handler = {}

function input_handler.click()
  local nodes = render_engine.find_by_position(mouse.getPosition())
  for _, v in ipairs(nodes) do
    if v.click then
      v:click()
    end
  end
end


mouse.on_click:add(input_handler.click)
return input_handler