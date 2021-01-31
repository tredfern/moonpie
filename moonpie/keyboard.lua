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

function Keyboard:keyPressed(key, scancode, isrepeat)
  local focused = require("moonpie.ui.user_focus"):getFocus()
  if focused and focused.keyPressed then
    focused:keyPressed(key, scancode, isrepeat)
  end

  local hot = self.hot_keys[self:calculateHotkey(key)]
  if hot then hot() end
end

function Keyboard:calculateHotkey(key)
  local modifiers = ""

  if Keyboard.isAltDown() then
    modifiers = modifiers .. "alt+"
  end

  if Keyboard.isCtrlDown() then
    modifiers = modifiers .. "ctrl+"
  end

  if Keyboard.isShiftDown() then
    modifiers = modifiers .. "shift+"
  end

  return modifiers .. key
end

function Keyboard:keyReleased(key, scancode)
  local focused = require("moonpie.ui.user_focus"):getFocus()
  if focused and focused.keyReleased then
    focused:keyReleased(key, scancode)
  end
end

function Keyboard:capture(component)
  self.capturing = component
end

function Keyboard.isShiftDown()
  return Keyboard.isDown("lshift") or Keyboard.isDown("rshift")
end

function Keyboard.isCtrlDown()
  return Keyboard.isDown("lctrl") or Keyboard.isDown("rctrl")
end

function Keyboard.isAltDown()
  return Keyboard.isDown("lalt") or Keyboard.isDown("ralt")
end

return setmetatable(Keyboard, { __index = love.keyboard })