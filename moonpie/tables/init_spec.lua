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

  it("has all the api functions we expect", function()
    assert.is_function(tables.all)
    assert.is_function(tables.any)
    assert.is_function(tables.assign)
    assert.is_function(tables.concat_array)
    assert.is_function(tables.copy_keys)
    assert.is_function(tables.count_by)
    assert.is_function(tables.find_first)
    assert.is_function(tables.group_by)
    assert.is_function(tables.has_keys)
    assert.is_function(tables.indexed)
    assert.is_function(tables.keys_to_list)
    assert.is_function(tables.map)
    assert.is_function(tables.max)
    assert.is_function(tables.merge)
    assert.is_function(tables.pack)
    assert.is_function(tables.pick_random)
    assert.is_function(tables.select)
    assert.is_function(tables.slice)
    assert.is_function(tables.sort_by)
    assert.is_function(tables.sum)
    assert.is_function(tables.to_array)
  end)

end)