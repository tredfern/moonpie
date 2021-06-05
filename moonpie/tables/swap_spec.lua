-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.swap", function()
  local swap = require "moonpie.tables.swap"

  it("changes the position of two elements in the table", function()
    local t = { 1, 2, 3, 4, 5, 6, 7, 8 }
    swap(t, 3, 8)
    assert.equals(8, t[3])
    assert.equals(3, t[8])
  end)
end)