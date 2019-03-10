-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("reverse", function()
  local reverse = require "moonpie.collections.iterators.reverse_iterator"

  it("returns each element from last to first", function()
    local set = {1, 2, 3, 4, 5}
    local test = 5
    for v in reverse(set) do
      assert.equals(test, v)
      test = test - 1
    end
  end)

  it("can return just a subset of the last elements", function()
    local set = {1, 2, 3, 4, 5}
    local count = 0
    for _ in reverse(set, 3) do
      count = count + 1
    end
    assert.equals(3, count)
  end)
end)
