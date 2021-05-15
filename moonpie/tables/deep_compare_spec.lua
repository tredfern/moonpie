-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.deep_compare", function()
  local deepCompare = require "moonpie.tables.deep_compare"

  it("matches tables that look the same", function()
    assert.is_true(deepCompare(
      { a = 1, b = 2, c = "hello" },
      { a = 1, b = 2, c = "hello" }
    ))
  end)

  it("matches tables that have nested subtables of values", function()
    assert.is_true(deepCompare(
      { a = { b = 1, c = { d = 3 }}},
      { a = { b = 1, c = { d = 3 }}}
    ))
  end)
end)