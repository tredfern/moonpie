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
end)
