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

  it("can provide an easy way to access the array", function()
    local g = Grid:new(10, 10)
    g:set(2, 2, "value")
    assert.equals("value", g(2, 2))
  end)

  it("can return a table containing the neighbors of a cell", function()
    local g = Grid:new(3, 3)
    g:set(1, 1, "1")
    g:set(2, 1, "2")
    g:set(3, 1, "3")
    g:set(1, 2, "4")
    g:set(2, 2, "5")
    g:set(3, 2, "6")
    g:set(1, 3, "7")
    g:set(2, 3, "8")
    g:set(3, 3, "9")

    local n = g:neighbors(1, 1)
    assert.is_nil(n.left)
    assert.is_nil(n.up)
    assert.equals("2", n.right)
    assert.equals("4", n.down)

    n = g:neighbors(2, 2)
    assert.equals("4", n.left)
    assert.equals("2", n.up)
    assert.equals("6", n.right)
    assert.equals("8", n.down)
  end)
end)
