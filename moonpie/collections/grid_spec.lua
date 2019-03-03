-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Grid", function()
  local Grid = require "moonpie.collections.grid"
  it("has a width and height", function()
    local g = Grid:new(39, 48)
    assert.equals(39, g.width)
    assert.equals(48, g.height)
  end)

  it("can get or set values based on coordinates", function()
    local g = Grid:new(384, 283)
    g:set(323, 128, "some value")
    assert.equals("some value", g:get(323, 128))
  end)

  it("returns nil if value is not set", function()
    local g = Grid:new(231, 239)
    assert.equals(nil, g:get(38, 43))
  end)
end)
