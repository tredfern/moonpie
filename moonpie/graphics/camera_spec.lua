-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Camera", function()
  local Camera = require "moonpie.graphics.camera"
  local mock_love = require "moonpie.test_helpers.mock_love"

  it("initializes to an inconsequential camera", function()
    local c = Camera:new()
    assert.equals(0, c.x)
    assert.equals(0, c.y)
    assert.equals(1, c.scale_x)
    assert.equals(1, c.scale_y)
  end)

  it("pushes on the translation stack on activate", function()
    mock_love.override_graphics("push", spy.new(function() end))
    local c = Camera:new()
    c:activate()
    assert.spy(love.graphics.push).was.called()
  end)

  it("pops the stack when the camera is deactivated", function()
    mock_love.override_graphics("pop", spy.new(function() end))
    local c = Camera:new()
    c:activate()
    c:deactivate()
    assert.spy(love.graphics.pop).was.called()
  end)

  it("translates based on the position of the camera", function()
    mock_love.override_graphics("translate", spy.new(function() end))
    local c = Camera:new()
    c:set_position(43, 29)
    c:activate()
    assert.spy(love.graphics.translate).was.called_with(43, 29)
  end)

  it("scales the camera", function()
    mock_love.override_graphics("scale", spy.new(function() end))
    local c = Camera:new()
    c:scale(10, 11)
    c:activate()
    assert.spy(love.graphics.scale).was.called_with(10, 11)
  end)
end)