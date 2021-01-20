-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.max", function()
  local max = require "moonpie.tables.max"

  it("returns the highest value in an array", function()
    local a = { 1, 2, 3, 6, 4, 3, 8, 6, 2 }
    assert.equals(8, max(a))
  end)

  it("can be passed a function to return the value", function()
    local a = {
      { b = 1 },
      { b = 2 },
      { b = 8 },
      { b = 2 },
    }

    assert.equals(8, max(a, function(item) return item.b end))
  end)

end)