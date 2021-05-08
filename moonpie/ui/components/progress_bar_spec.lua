-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.ui.components.progress_bar", function()
  local moonpie = require "moonpie"
  local progress_bar = require "moonpie.ui.components.progress_bar"
  local mock_love = require "moonpie.test_helpers.mock_love"

  it("takes a maximum value to calculate percentage from, defaults to 100", function()
    local pb = progress_bar()
    assert.equals(100, pb.maximum)
    pb = progress_bar { maximum = 1249 }
    assert.equals(1249, pb.maximum)
  end)

  it("draws a rectangle based on the current progress to the maximum", function()
    local color = { 1, 1, 1, 1 }
    local pb = progress_bar { id = "pb", width = 100, height = 50, color = color }
    local out = moonpie.testRender(pb)
    local node = out:findByID("pb")
    pb.current = 25
    mock_love.mock(love.graphics, "setColor", spy.new(function() end))
    mock_love.mock(love.graphics, "rectangle", spy.new(function() end))
    node:drawComponent()

    assert.spy(love.graphics.setColor).was.called_with(color)
    assert.spy(love.graphics.rectangle).was.called_with("fill", 0, 0, 25, 50)
  end)
end)