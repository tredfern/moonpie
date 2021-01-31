-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.concat_array", function()
  local concatArray = require "moonpie.tables.concat_array"

  it("returns a new array with elements in each array", function()
    local a = { 1, 2, 3 }
    local b = { 4, 5, 6 }

    local c = concatArray(a, b)
    assert.same( { 1, 2, 3, 4, 5, 6 }, c)
  end)

  it("joins multiple arrays together", function()
    local a = { 1, 2 }
    local b = { 3, 4 }
    local c = { 5, 6 }
    local d = { 7, 8 }

    local e = concatArray(a, b, c, d)
    assert.same({ 1, 2, 3, 4, 5, 6, 7, 8 }, e)
  end)

  it("skips nil arrays", function()
    local a = { 1, 2, 3 }
    local b = { 4, 5, 6 }
    local c = concatArray(nil, a, nil, nil, b)
    assert.same({ 1, 2, 3, 4, 5, 6 }, c)
  end)
end)