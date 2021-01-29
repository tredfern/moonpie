-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.join", function()
  local join = require "moonpie.tables.join"

  it("takes two arrays and joins them together", function()
    local a = { 1, 2, 3, 4 }
    local b = { 5, 6, 7, 8 }

    local c = join(a, b)
    assert.array_includes(7, c)
    assert.array_includes(3, c)
    assert.equals(8, #c)
  end)

  it("works with any number of arrays", function()
    local a = { 1, 2 }
    local b = { 5, 6 }
    local c = { 3, 4 }
    local d = { 7, 8 }

    local e = join(a, b, c, d)
    assert.array_includes(7, e)
    assert.array_includes(3, e)
    assert.equals(8, #e)
  end)
end)