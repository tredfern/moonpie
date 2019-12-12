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

  describe("Capture", function()
    before_each(function()
      keyboard:reset()
    end)

    it("sends keypressed event to the capturing component", function()
      local component = { keypressed = spy.new(function() end) }
      keyboard:capture(component)
      keyboard:keypressed("a", "scancode", "isrepeat")
      assert.spy(component.keypressed).was.called_with(component, "a", "scancode", "isrepeat")
    end)

    it("sends keyreleased event to the capturing component", function()
      local component = { keyreleased = spy.new(function() end) }
      keyboard:capture(component)
      keyboard:keyreleased("a", "scancode")
      assert.spy(component.keyreleased).was.called_with(component, "a", "scancode")
    end)
  end)
end)
