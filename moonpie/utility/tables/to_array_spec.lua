-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.tables.to_array", function()
  local tables = require "moonpie.utility.tables"

  it("takes a dictionary and converts it to a flat array", function()
    local dict = { a = 1, b = 2, c = 3 }
    assert.array_includes_all({1, 2, 3}, tables.to_array(dict))
  end)
end)