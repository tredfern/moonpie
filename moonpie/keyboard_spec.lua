-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Keyboard", function()
  local mock_love = require "moonpie.test_helpers.mock_love"
  local keyboard = require "moonpie.keyboard"

  it("provides functionality provided by love keyboard by default", function()
    assert.equals("function", type(keyboard.isDown))
  end)

  it("reset clears all state tracking", function()
    mock_love.simulate_key_down("a")
    mock_love.simulate_key_down("1")
    keyboard:hotkey("a", function() end)
    keyboard:reset()
    assert.is_nil(keyboard.key_down["a"])
    assert.is_nil(keyboard.key_down["1"])
    assert.is_nil(keyboard.hot_keys["a"])
  end)

  describe("Hot Keys", function()
    before_each(function()
      keyboard:reset()
    end)

    it("calls a function when a hot key is mapped to it", function()
      local cb = spy.new(function() end)
      keyboard:hotkey("a", cb)
      mock_love.simulate_key_down("a")
      keyboard:update()
      assert.spy(cb).was.called()
    end)

    it("only calls the hot key once per down event", function()
      local count = 0
      local cb = function() count = count + 1 end
      keyboard:hotkey("a", cb)
      mock_love.simulate_key_down("a")
      keyboard:update()
      keyboard:update()
      keyboard:update()
      assert.equals(1, count)
      mock_love.simulate_key_up("a")
      keyboard:update()
      mock_love.simulate_key_down("a")
      keyboard:update()
      assert.equals(2, count)
    end)
  end)
end)
