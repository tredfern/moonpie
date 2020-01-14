-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Scene", function()
  local Scene = require "moonpie.scene"
  local moonpie = require "moonpie"

  it("can render a screen to the ui", function()
    local a = Scene:new()
    local c = {}
    moonpie.render = spy.new(function() end)
    a:ui(c)
    assert.spy(moonpie.render).was.called_with("ui", c)
  end)

  it("registers callback for update", function()
    local a = Scene:new( )
    a.update = spy.new(function() end)
    moonpie.update()
    assert.spy(a.update).was.called.with(a)
  end)
end)