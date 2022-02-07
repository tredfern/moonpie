-- Copyright (c) 2022 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.select_type", function()
  local selectType = require "moonpie.tables.select_type"

  it("filters items out based on the type of item it is", function()
    local t = { 1, 2, "foo", 3, 5, "bar", function() end, {}, {} }

    local s = selectType(t, "string")
    assert.equals(2, #s)
    assert.array_includes("foo", s)
    assert.array_includes("bar", s)
    assert.not_array_includes(1, s)

    local f = selectType(t, "function")
    assert.equals(1, #f)

    local tbls = selectType(t, "table")
    assert.equals(2, #tbls)

    local n = selectType(t, "number")
    assert.equals(4, #n)
  end)
end)