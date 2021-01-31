-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.countBy", function()
  local tables = require "moonpie.tables"

  it("returns a list of values that match a certain grouping", function()
    local set = { 1, 2, 3, 4, 5 }
    local counts = tables.countBy(set,
      function(v)
        if v % 2 == 0 then
          return "even"
        else
          return "odd"
        end
      end
    )

    assert.equals(3, counts.odd)
    assert.equals(2, counts.even)
  end)
end)