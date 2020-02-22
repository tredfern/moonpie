-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.tables.map", function()
  local tables = require "moonpie.utility.tables"

  it("can translate one table into another via a function", function()
    local numbers = { 1, 2, 3, 4, 5 }
    local strings = tables.map(numbers, function(n) return tostring(n) end)
    assert.array_matches({"1", "2", "3", "4", "5"}, strings)
  end)
end)