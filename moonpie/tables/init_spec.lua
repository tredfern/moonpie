-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables", function()
  local tables = require "moonpie.tables"

  it("can copy keys", function()
    assert.not_nil(tables.copy_keys)
  end)

  it("can check for keys", function()
    assert.not_nil(tables.has_keys)
  end)

  it("can merge tables", function()
    assert.not_nil(tables.merge)
  end)

  it("can choose a random element from a table", function()
    local items = { 1, 2, 3, 4, 5 }
    assert.in_range(1, 5, tables.pick_random(items))
  end)
end)