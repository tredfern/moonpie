-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Region", function()
  local region = require "moonpie.region"

  it("is initialized with left, top, right, bottom", function()
    local r = region(1, 2, 3, 4)
    assert.equals(1, r.left)
    assert.equals(2, r.top)
    assert.equals(3, r.right)
    assert.equals(4, r.bottom)
  end)

  it("can return whether coordinates are contained within the region", function()
    local r = region(10, 10, 30, 30)
    assert.is_true(r:contains(12, 12))
    assert.is_true(r:contains(29, 29))
    assert.is_true(r:contains(10, 10))
    assert.is_true(r:contains(30, 30))

    assert.is_false(r:contains(31, 29))
    assert.is_false(r:contains(10, 9))
    assert.is_false(r:contains(-4, 0))
  end)
end)
