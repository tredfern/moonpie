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

  it("dispatches mouse down events to the appropriate nodes", function()
    local component = {
      mouseDown = spy.new(function() end),
      width = 100, height = 100
    }
    RenderEngine("ui", component)
    MockLove.moveMouse(5, 10)
    Mouse.onMouseDown(1)
    assert.spy(component.mouseDown).was.called()
  end)

  it("dispatches mouse up events to the appropriate nodes", function()
    local component = {
      mouseUp = spy.new(function() end),
      width = 100, height = 100
    }
    RenderEngine("ui", component)
    MockLove.moveMouse(5, 10)
    Mouse.onMouseUp(2)
    assert.spy(component.mouseUp).was.called()
  end)

  it("triggers an audio sound on click", function()
    local component = {
      clickSound = { play = spy.new(function() end) },
      width = 100, height = 100
    }

    RenderEngine("ui", component)
    MockLove.moveMouse(5, 10)
    Mouse.onClick()
    assert.spy(component.clickSound.play).was.called_with(component.clickSound)
  end)

  it("triggers mouse move events", function()
    local component = {
      onMouseMove = spy.new(function() end),
      width = 100, height = 100
    }
    RenderEngine("ui", component)
    MockLove.moveMouse(5, 10)
    MockLove.moveMouse(8, 12)
    Mouse:update()
    assert.spy(component.onMouseMove).was.called()
  end)
end)