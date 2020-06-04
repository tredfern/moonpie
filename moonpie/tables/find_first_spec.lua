-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.find_first", function()
  local find_first = require "moonpie.tables.find_first"

  it("finds the first element matching a query function", function()
    local set = { 1, 2, 3, 4, 5 }
    local out = find_first(set, function(v) return v == 4 end)
    assert.equals(4, out)
  end)
end)