-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.map_keys", function()
  local tables = require "moonpie.tables"

  it("works with keyed sets", function()
    local key_set = {
      a = 1, b = 2, c = 3
    }
    local mapped = tables.mapKeys(key_set, function(n, k) return k .. tostring(n) end)
    assert.array_includes_all({ "a1", "b2", "c3" }, mapped)
  end)
end)