-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.tables.count_by", function()
  local tables = require "moonpie.utility.tables"

  it("returns a list of values that match a certain grouping", function()
    local set = { 1, 2, 3, 4, 5 }
    local counts = tables.count_by(set,
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