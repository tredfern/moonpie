-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.ui.components.root", function()
  local components = require "moonpie.ui.components"

  it("sets it's width and height to the current screen settings", function()
    local r = components.root()
    local w, h = love.graphics.getDimensions()
    assert.equals(w, r.width)
    assert.equals(h, r.height)
  end)

  it("registers and handles window_resize event", function()
    local r = components.root()
    local events = require "moonpie.events"
    events.window_resize:trigger(800, 600)
    assert.is_true(r:hasUpdates())
    assert.equals(800, r.width)
    assert.equals(600, r.height)
  end)
end)