-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.count", function()
  local count = require "moonpie.tables.count"

  it("returns the number of items matching a function", function()
    local set = { 1, 2, 3, 4, 5, 6 }

    assert.equals(3, count(set, function(i) return i % 2 == 0 end))
  end)

  it("just returns the number of items if no function provided", function()
    local set = { 1, 2, 3, 4, 5, 6 }
    assert.equals(6, count(set))
  end)
end)