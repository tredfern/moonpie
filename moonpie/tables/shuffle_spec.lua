-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.shuffle", function()
  local shuffle = require "moonpie.tables.shuffle"

  it("returns an array that contains all the values", function()
    local a = {1, 2, 3, 4, 5}

    shuffle(a)
    assert.array_includes(1, a)
    assert.array_includes(2, a)
    assert.array_includes(3, a)
    assert.array_includes(4, a)
    assert.array_includes(5, a)
  end)

  it("returns the array in different orders", function()
    local a = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 }
    local b = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 }

    shuffle(a)
    local somethingDifferent = false
    for i = 1, #b do
      somethingDifferent = somethingDifferent or a[i] ~= b[i]
    end
    assert.is_true(somethingDifferent)
  end)
end)