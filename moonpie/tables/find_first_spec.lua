-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.find_first", function()
  local findFirst = require "moonpie.tables.find_first"

  it("finds the first element matching a query function", function()
    local set = { 1, 2, 3, 4, 5 }
    local out = findFirst(set, function(v) return v == 4 end)
    assert.equals(4, out)
  end)

  it("returns the index of the found entity as the second result", function()
    local set = { 5, 4, 3, 2, 1 }
    local out, index = findFirst(set, function(v) return v == 4 end)
    assert.equals(4, out)
    assert.equals(2, index)
  end)
end)