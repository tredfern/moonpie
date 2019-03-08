-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("RandomIterator", function()
  local irandom = require "moonpie.collections.random_iterator"
  local MockRandom = require "moonpie.test_helpers.mock_random"

  it("returns elements in a random sequence", function()
    local t = {1, 2, 3, 4, 5}
    local seq = {2, 4, 3, 1, 1}
    local results = {2, 4, 3, 1, 5}
    MockRandom.setreturnvalues(seq)

    local count = 1
    for v in irandom(t) do
      assert.equals(results[count], v, "count: " .. count)
      count = count + 1
    end
  end)
end)
