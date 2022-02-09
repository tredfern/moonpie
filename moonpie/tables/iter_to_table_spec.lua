-- Copyright (c) 2022 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.iter_to_table", function()
  local iterToTable = require "moonpie.tables.iter_to_table"

  it("takes an iterator and makes a table out of the elements", function()
    local reverse = require "moonpie.collections.iterators.reverse"
    local t = { 1, 2, 3, 4, 5 }
    local out = iterToTable(reverse(t))

    assert.same({ 5, 4, 3, 2, 1}, out)
  end)
end)