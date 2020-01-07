-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Keyboard", function()
  local keyboard = require "moonpie.keyboard"

  it("provides functionality provided by love keyboard by default", function()
    assert.equals("function", type(keyboard.isDown))
  end)

  it("reset clears all hotkey tracking", function()
    keyboard:hotkey("a", function() end)
    keyboard:reset()
    assert.is_nil(keyboard.hot_keys["a"])
  end)

  describe("Hot Keys", function()
    before_each(function()
      keyboard:reset()
    end)

    it("calls a function when a hot key is mapped to it", function()
      local cb = spy.new(function() end)
      keyboard:hotkey("a", cb)
      keyboard:keypressed("a")
      assert.spy(cb).was.called()
    end)
  end)

  describe("route key events", function()
    local Components = require("moonpie.ui.components")
    Components("test_keyboard", function() return {} end)
    it("sends keypress events to component that has focus", function()
      local c = Components.test_keyboard()
      c.keypressed = spy.new(function() end)
      c:set_focus()
      keyboard:keypressed("a", "scan", "isrepeat")
      assert.spy(c.keypressed).was.called()
      assert.spy(c.keypressed).was.called_with(c, "a", "scan", "isrepeat")
    end)

    it("sends keyreleased events to component that has focus", function()
      local c = Components.test_keyboard()
      c.keyreleased = spy.new(function() end)
      c:set_focus()
      keyboard:keyreleased("a", "scan")
      assert.spy(c.keyreleased).was.called()
      assert.spy(c.keyreleased).was.called_with(c, "a", "scan")
    end)

    it("does not error on keypressed or keyreleased events when no component has focus", function()
      require("moonpie.ui.user_focus"):clear()
      assert.has_no.errors(function() keyboard:keypressed("a") end)
      assert.has_no.errors(function() keyboard:keyreleased("a") end)
    end)

    it("does not error if no keypressed or keyreleased handlers are defined", function()
      Components("test_no_key_handler", function() return {} end)
      local c = Components.test_no_key_handler()
      c:set_focus()
      assert.has_no.errors(function() keyboard:keypressed("a") end)
      assert.has_no.errors(function() keyboard:keyreleased("a") end)
    end)
  end)
end)
