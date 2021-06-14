-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.pop_random", function()
  local popRandom = require "moonpie.tables.pop_random"

  it("selects a random value and removes it from the list", function()
    local list = { 6, 7, 8, 9, 10 }
    local v = popRandom(list)
    assert.in_range(6, 10, v)
    assert.not_array_includes(v, list)
    assert.equals(4, #list)
  end)

  it("returns nil if the list is empty", function()
    assert.is_nil(popRandom({}))
  end)
end)