-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.sum", function()
  local tables = require "moonpie.tables"


  it("adds all the elements of an array together", function()
    local s = tables.sum{ 1, 2, 3, 4, 5}
    assert.equals(15, s)
  end)

  it("can be provided a function to return an integer that performs the sum", function()
    local s = tables.sum({ 1, 2, 3, 4, 5}, function(v) return v / 2 end)
    assert.equals(7.5, s)
  end)
end)