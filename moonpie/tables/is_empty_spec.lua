-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.is_empty", function()
  local isEmpty = require "moonpie.tables.is_empty"

  it("return true if there are 0 elements in the list", function()
    assert.is_true(isEmpty({}))
  end)

  it("returns true if table is nil", function()
    assert.is_true(isEmpty(nil))
  end)

  it("returns false if list contains items", function()
    assert.is_false(isEmpty{ 1, 2, 3 })
  end)
end)