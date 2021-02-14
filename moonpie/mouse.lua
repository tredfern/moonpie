-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local callback = require "moonpie.callback"

local BUTTON_COUNT = 4
local mouse = {
  button_states = {},
  onClick = callback:new(),
  onMouseDown = callback:new(),
  onMouseMove = callback:new(),
  onMouseUp = callback:new(),
}

function mouse:checkPrimaryButton()
  if not self.isDown(1) and self.button_states[1] then
    self.onClick()
  end
end

function mouse:updateButtonStates()
  for i=1,BUTTON_COUNT do
    if not self.button_states[i] and self.isDown(i) then
      mouse.onMouseDown(i)
    elseif self.button_states[i] and not self.isDown(i) then
      mouse.onMouseUp(i)
    end
    self.button_states[i] = self.isDown(i)
  end
end

function mouse:update()
  self:checkPosition()
  self:checkPrimaryButton()
  self:updateButtonStates()
end

function mouse:checkPosition()
  local x, y = mouse:getPosition()
  if self.previousX ~= x or self.previousY ~= y then
    mouse.onMouseMove(x, y)
    self.previousX = x
    self.previousY = y
  end
end

return setmetatable(mouse, {
  __index = love.mouse
})
