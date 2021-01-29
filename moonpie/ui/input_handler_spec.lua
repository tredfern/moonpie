-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.ui.input_handler", function()
  local mock_love = require "moonpie.test_helpers.mock_love"
  local mouse = require "moonpie.mouse"
  local input_handler = require "moonpie.ui.input_handler"
  local render_engine = require "moonpie.ui.render_engine"

  it("dispatches mouse events to the appropriate nodes", function()
    local component = {
      click = spy.new(function() end),
      width = 100, height = 100
    }
    render_engine("ui", component)
    mock_love.move_mouse(5, 10)
    mouse.on_click()
    assert.spy(component.click).was.called()
  end)
end)