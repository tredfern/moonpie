-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.tables.any", function()
  local tables = require "moonpie.utility.tables"

  it("returns true if any element passes the test", function()
    local set = { 1, 3, 5, 7, 8 }
    assert.is_true(tables.any(set, function(nu) return nu % 2 == 0 end))
  end)

  it("returns false if all elements fail the test", function()
    local set = { 1, 3, 5, 7, 9 }
    assert.is_false(tables.any(set, function(nu) return nu % 2 == 0 end))
  end)
end)