-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.ui.input_handler", function()
  local MockLove = require "moonpie.test_helpers.mock_love"
  local Mouse = require "moonpie.mouse"
  require "moonpie.ui.input_handler"
  local RenderEngine = require "moonpie.ui.render_engine"

  it("dispatches mouse events to the appropriate nodes", function()
    local component = {
      click = spy.new(function() end),
      width = 100, height = 100
    }
    RenderEngine("ui", component)
    MockLove.moveMouse(5, 10)
    Mouse.onClick()
    assert.spy(component.click).was.called()
  end)
end)