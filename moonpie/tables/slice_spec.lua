-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.slice", function()
  local tables = require "moonpie.tables"

  it("returns a subset of an array", function()
    local a = { 1, 2, 3, 4, 5, 6, 7 }
    assert.array_matches({3, 4, 5 }, tables.slice(a, 3, 5))
  end)

  it("defaults to returning to the end of the array", function()
    local a = { 1, 2, 3, 4, 5, 6, 7 }
    assert.array_matches({3, 4, 5, 6, 7 }, tables.slice(a, 3))
  end)

  it("defaults to the start of the array", function()
    local a = { 1, 2, 3, 4, 5, 6, 7 }
    assert.array_matches({1, 2, 3, 4, 5 }, tables.slice(a, nil, 5))
  end)

  it("can quickly slice from the end", function()
    local a = { 1, 2, 3, 4, 5, 6, 7, 8 }
    assert.array_matches( { 5, 6, 7, 8 } , tables.slice(a, -4))
  end)
end)