-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Keyboard = {}
Keyboard.hot_keys = {}

function Keyboard:hotkey(key, callback)
  self.hot_keys[key] = callback
end

function Keyboard:reset()
    self.hot_keys = {}
end

function Keyboard:keypressed(key, scancode, isrepeat)
  local focused = require("moonpie.ui.user_focus"):get_focus()
  if focused and focused.keypressed then
    focused:keypressed(key, scancode, isrepeat)
  end

  local hot = self.hot_keys[self:calculate_hotkey(key)]
  if hot then hot() end
end

function Keyboard:calculate_hotkey(key)
  local modifiers = ""

  if Keyboard.is_alt_down() then
    modifiers = modifiers .. "alt+"
  end

  if Keyboard.is_ctrl_down() then
    modifiers = modifiers .. "ctrl+"
  end

  if Keyboard.is_shift_down() then
    modifiers = modifiers .. "shift+"
  end

  return modifiers .. key
end

function Keyboard:keyreleased(key, scancode)
  local focused = require("moonpie.ui.user_focus"):get_focus()
  if focused and focused.keyreleased then
    focused:keyreleased(key, scancode)
  end
end

function Keyboard:capture(component)
  self.capturing = component
end

function Keyboard.is_shift_down()
  return Keyboard.isDown("lshift") or Keyboard.isDown("rshift")
end

function Keyboard.is_ctrl_down()
  return Keyboard.isDown("lctrl") or Keyboard.isDown("rctrl")
end

function Keyboard.is_alt_down()
  return Keyboard.isDown("lalt") or Keyboard.isDown("ralt")
end

return setmetatable(Keyboard, { __index = love.keyboard })