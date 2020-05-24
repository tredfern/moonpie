-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.pick_random", function()
  local pick_random = require "moonpie.tables.pick_random"
  it("can choose a random element from a table", function()
    local items = { 1, 2, 3, 4, 5 }
    assert.in_range(1, 5, pick_random(items))
  end)
end)