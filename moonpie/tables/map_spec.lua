-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.map", function()
  local tables = require "moonpie.tables"

  it("can translate one table into another via a function", function()
    local numbers = { 1, 2, 3, 4, 5 }
    local strings = tables.map(numbers, function(n) return tostring(n) end)
    assert.array_matches({"1", "2", "3", "4", "5"}, strings)
  end)

  it("receives the index of the item being operated on", function()
    local numbers = { 1, 2, 3, 4, 5 }
    local strings = tables.map(numbers, function(n, i) return tostring(n + i) end)
    assert.array_matches({"2", "4", "6", "8", "10"}, strings)
  end)

  it("returns nil if table is nil", function()
    assert.is_nil(tables.map(nil))
  end)

end)