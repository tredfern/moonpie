-- Copyright (c) 2022 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.math.weighted_table", function()
  local WeightedTable = require "moonpie.math.weighted_table"
  local MockRandom = require "moonpie.test_helpers.mock_random"

  it("can add items to table", function()
    local wt = WeightedTable.new()
    wt:add("a", 10)
    wt:add("b", 13)
    wt:add("c", 14)

    assert.equals(37, wt.totalWeight)
    assert.equals(3, #wt)
  end)

  it("can be initialized with a table", function()
    local wt = WeightedTable.new({
      { "a", 10 },
      { "b", 13 },
      { "c", 14 }
    })

    assert.equals("a", wt[1].item)
    assert.equals(10, wt[1].weight)
    assert.equals("b", wt[2].item)
    assert.equals(13, wt[2].weight)
    assert.equals("c", wt[3].item)
    assert.equals(14, wt[3].weight)
  end)

  it("randomly selects an item based on the weighting of the items", function()
    MockRandom.setreturnvalues({ 1, 17 })
    local wt = WeightedTable.new()
    wt:add("a", 10)
    wt:add("b", 13)

    assert.equals("a", wt:choose())
    assert.equals("b", wt:choose())
  end)
end)