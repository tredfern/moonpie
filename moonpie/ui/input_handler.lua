-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Mouse = require "moonpie.mouse"
local RenderEngine = require "moonpie.ui.render_engine"
local InputHandler = {}

function InputHandler.click()
  local nodes = RenderEngine.findByPosition(Mouse.getPosition())
  for _, v in ipairs(nodes) do
    if v.click then
      v:click()
    end
  end
end


Mouse.onClick:add(InputHandler.click)
return InputHandler