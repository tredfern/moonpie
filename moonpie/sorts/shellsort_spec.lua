-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("ShellSort", function()
  local ShellSort = require "moonpie.sorts.shellsort"
  it("sorts elements as expected", function()
    local list = { "orange", "apple", "banana", "rhubarb", "nectarine", "peach", "blueberry" }
    local r = ShellSort(list)
    assert.array_matches({ "apple", "banana", "blueberry", "nectarine", "orange", "peach", "rhubarb" }, r)
  end)

  it("it sorts the actual array", function()
    local list = { 38, 9, 2, 203, 8, 28, 10, 11, 48, 29, 6, 7, 92, 1000, 843, 928, 842, 292, 384, 596, 10293, 1 }
    ShellSort(list)
    assert.array_matches(
      { 1, 2, 6, 7, 8, 9, 10, 11, 28, 29, 38, 48, 92, 203, 292, 384, 596, 842, 843, 928, 1000, 10293 },
      list)
  end)

  it("can deal with duplicate values", function()
    local list = { 2, 4, 2, 9, 4, 1, 8, 4 }
    ShellSort(list)
    assert.array_matches({ 1, 2, 2, 4, 4, 4, 8, 9}, list)
  end)

  it("can support a custom comparison", function()
    local list = { 1, 2, 3, 4 }
    ShellSort(list, function(a, b) return a > b end)
    assert.array_matches({4, 3, 2, 1}, list)
  end)
end)
