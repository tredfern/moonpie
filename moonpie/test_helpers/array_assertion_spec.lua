-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("array_assertions", function()
  it("can check if an array includes an item", function()
    local t = {1,2,3,4,5,6,7}
    assert.array_includes(1, t)
    assert.is_not.array_includes(10, t)
  end)

  it("can specify if an array is empty", function()
    local empty = {}
    local not_empty = {1, 2, 3}
    assert.empty_array(empty)
    assert.is_not.empty_array(not_empty)
  end)

  it("can check if an array matches", function()
    local a1 = { 1, 2, 3 }
    local a2 = { 1, 2, 3 }
    local a3 = { 1, 2, 3, 4, 5 }
    assert.array_matches(a1, a2)
    assert.not_array_matches(a1, a3)
  end)

  it("can check if sets includes all of a set", function()
    local a1 = { 1, 2, 3 }
    local a2 = { 2, 3, 1 }
    local a3 = { 1, 2, 3, 4, 5 }
    assert.not_array_matches(a1, a2)
    assert.array_includes_all(a1, a2)
    assert.array_includes_all(a1, a3)
  end)
end)
