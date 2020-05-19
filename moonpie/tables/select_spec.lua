-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.select", function()
  local tables = require "moonpie.tables"

  it("returns a new array with matching elements", function()
    local set = { 1, 2, 3, 4, 5, 6, 7, 8 }

    local result = tables.select(set, function(num) return num % 2 == 0 end)
    assert.array_matches({ 2, 4, 6, 8 }, result)
  end)
end)