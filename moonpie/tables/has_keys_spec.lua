-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.hasKeys", function()
  local tables = require "moonpie.tables"

  it("returns true if table contains all keys", function()
    local t = { a = 1, b = 2, c = 3, d = 4 }
    assert.is_true(tables.hasKeys(t, "a", "b", "c", "d"))
  end)

  it("returns false if table is missing any key", function()
    local t = { a = 1, b = 2, c = 3 }
    assert.is_false(tables.hasKeys(t, "a", "b", "c", "d"))
  end)
end)