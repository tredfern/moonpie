-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local callback = require "moonpie.callback"

local BUTTON_COUNT = 4
local mouse = {
  button_states = {},
  onClick = callback:new(),
  on_mousedown = callback:new(),
  on_mouseup = callback:new(),
}

function mouse:check_primary_button()
  if not self.isDown(1) and self.button_states[1] then
    self.onClick()
  end
end

function mouse:update_button_states()
  for i=1,BUTTON_COUNT do
    if not self.button_states[i] and self.isDown(i) then
      mouse.on_mousedown(i)
    elseif self.button_states[i] and not self.isDown(i) then
      mouse.on_mouseup(i)
    end
    self.button_states[i] = self.isDown(i)
  end
end

function mouse:update()
  self:check_primary_button()
  self:update_button_states()
end

return setmetatable(mouse, {
  __index = love.mouse
})
