-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.take", function()
  local take = require "moonpie.tables.take"

  it("returns that specified number of elements from the table", function()
    local t = { 1, 2, 3, 4, 5, 6 }
    local out = take(t, 3)
    assert.same({ 1, 2, 3 }, out)
  end)

  it("removes from the original table the elements taken", function()
    local t = { 1, 2, 3, 4, 5, 6 }
    take(t, 3)
    assert.equals(3, #t)
  end)
end)