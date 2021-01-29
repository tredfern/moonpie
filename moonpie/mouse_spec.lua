-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Mouse", function()
  local mock_love = require "moonpie.test_helpers.mock_love"
  local mouse = require "moonpie.mouse"

  describe("update", function()
    describe("events", function()
      it("triggers the mouse down event", function()
        local handler = spy.new(function() end)
        mouse.on_mousedown:add(spy_to_func(handler))
        mock_love.simulate_button_down(1)
        mouse:update()
        assert.spy(handler).was.called_with(1)
        mock_love.simulate_button_down(2)
        mouse:update()
        assert.spy(handler).was.called_with(2)
      end)

      it("triggers the mouse up event", function()
        local handler = spy.new(function() end)
        mouse.on_mouseup:add(spy_to_func(handler))
        mock_love.simulate_button_down(1)
        mock_love.simulate_button_down(2)
        mouse:update()
        mock_love.simulate_button_up(2)
        mouse:update()
        assert.spy(handler).was.called_with(2)
        assert.spy(handler).was_not.called_with(1)
      end)

      it("triggers the click event that can be registered", function()
        local handler = spy.new(function() end)
        mouse.on_click:add(spy_to_func(handler))
        mock_love.simulate_button_down(1)
        mouse:update()
        mock_love.simulate_button_up(1)
        mouse:update()
        assert.spy(handler).was.called()
      end)
    end)
  end)
end)
