-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.min", function()
  local min = require "moonpie.tables.min"

  it("finds the lowest value in an array", function()
    local a = { 1, 4, 8, -2, 3, 4, 12 }
    assert.equals(-2, min(a))
  end)

  it("accepts a function to retrieve value", function()
    local a = {
      { x = 1 }, { x = 4 }, { x = -9 }, { x = 3 }
    }
    assert.equals(-9, min(a, function(item) return item.x end))
  end)
end)