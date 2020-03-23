-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.tables.all", function()
  local tables = require "moonpie.utility.tables"

  it("returns true if all elements pass test", function()
    local set = { 2, 4, 6, 8, 10 }
    assert.is_true(tables.all(set, function(num) return num % 2 == 0 end))
  end)

  it("returns false if any element fails test", function()
    local set = { 2, 4, 6, 7, 10 }
    assert.is_false(tables.all(set, function(num) return num % 2 == 0 end))
  end)
end)