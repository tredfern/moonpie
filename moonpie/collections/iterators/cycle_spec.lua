-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Cycle iterator", function()
  local cycle = require "moonpie.collections.iterators.cycle"

  it("loops around elements continuously", function()
    local set = { 1, 2, 3 }
    local c = cycle(set)
    assert.equals(1, c())
    assert.equals(2, c())
    assert.equals(3, c())
    assert.equals(1, c())
    assert.equals(2, c())
    assert.equals(3, c())
    assert.equals(1, c())
  end)

  it("can be specified to perform a certain number of loops", function()
    local set = { 1, 2, 3 }
    local c = cycle(set, 2)
    assert.equals(1, c())
    assert.equals(2, c())
    assert.equals(3, c())
    assert.equals(1, c())
    assert.equals(2, c())
    assert.equals(3, c())
    assert.is_nil(c())
  end)

  it("can be used like a table with a next method", function()
    local set = { 1, 2, 3 }
    local c = cycle(set)
    assert.equals(1, c.next())
    assert.equals(2, c.next())
  end)

  it("can retrieve the previous item of the cycle", function()
    local set = { 1, 2, 3 }
    local c = cycle(set)
    assert.equals(1, c.next())
    assert.equals(3, c.previous())
    assert.equals(2, c.previous())
  end)

  it("returns the index of the item", function()
    local set = { "a", "b", "c", "d" }
    local c = cycle(set)
    local v, i = c()
    assert.equals("a", v)
    assert.equals(1, i)
    v, i = c()
    assert.equals("b", v)
    assert.equals(2, i)
  end)
end)
