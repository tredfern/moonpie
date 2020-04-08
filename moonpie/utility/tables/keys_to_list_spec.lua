-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.tables.keys_to_list", function()
  local tables = require "moonpie.utility.tables"

  it("takes a list of keys and converts it to a set", function()
    local t = {
      a = 1,
      b = 2,
      c = 3
    }

    local s = tables.keys_to_list(t)
    assert.equals(3, #s)
    assert.array_includes(1, s)
    assert.array_includes(2, s)
    assert.array_includes(3, s)
  end)
end)