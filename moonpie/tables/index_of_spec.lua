-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.index_of", function()
  local indexOf = require "moonpie.tables.index_of"

  it("finds the index of an item", function()
    local find = {}
    local tbl = { {}, {}, find, {}}
    assert.equals(3, indexOf(tbl, find))
  end)
end)