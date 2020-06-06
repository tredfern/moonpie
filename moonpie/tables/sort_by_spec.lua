-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.sort_by", function()
  local sort_by = require "moonpie.tables.sort_by"

  it("sorts a keyed set based on a function", function()
    local set = { a = 1, c = 4, b = 6, d = 12 }
    local result = sort_by(set, function(k) return k end)
    assert.equals("a", result[1].key)
    assert.equals(1, result[1].value)
    assert.equals("b", result[2].key)
    assert.equals(6, result[2].value)
    assert.equals("c", result[3].key)
    assert.equals(4, result[3].value)
    assert.equals("d", result[4].key)
    assert.equals(12, result[4].value)
  end)
end)