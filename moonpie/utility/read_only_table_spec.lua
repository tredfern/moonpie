-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.read_only_table", function()
  local readOnlyTable = require "moonpie.utility.read_only_table"

  it("can make a table immutable", function()
    local tbl = { a = 1, b = 2, c = "SOMETHING" }
    local ro = readOnlyTable(tbl)
    assert.equals(1, ro.a)
    assert.equals(2, ro.b)
    assert.equals("SOMETHING", ro.c)
    assert.has_errors(function() ro.d = 323 end)
  end)
end)