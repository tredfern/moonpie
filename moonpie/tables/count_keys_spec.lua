-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.count_keys", function()
  local countKeys = require "moonpie.tables.count_keys"

  it("returns the count of all index and key entries", function()
    local t = { 1, 2, 3, a = 4, b = 5, c = 6 }

    assert.equals(6, countKeys(t))
  end)
end)