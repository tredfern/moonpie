-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.tables.concat_array", function()
  local concat_array = require "moonpie.utility.tables.concat_array"

  it("returns a new array with elements in each array", function()
    local a = { 1, 2, 3 }
    local b = { 4, 5, 6 }

    local c = concat_array(a, b)
    assert.same( { 1, 2, 3, 4, 5, 6 }, c)
  end)

  it("joins multiple arrays together", function()
    local a = { 1, 2 }
    local b = { 3, 4 }
    local c = { 5, 6 }
    local d = { 7, 8 }

    local e = concat_array(a, b, c, d)
    assert.same({ 1, 2, 3, 4, 5, 6, 7, 8 }, e)
  end)

  it("skips nil arrays", function()
    local a = { 1, 2, 3 }
    local b = { 4, 5, 6 }
    local c = concat_array(nil, a, nil, nil, b)
    assert.same({ 1, 2, 3, 4, 5, 6 }, c)
  end)
end)