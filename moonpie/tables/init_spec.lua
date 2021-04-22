-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables", function()
  local tables = require "moonpie.tables"

  it("can copy keys", function()
    assert.not_nil(tables.copyKeys)
  end)

  it("can check for keys", function()
    assert.not_nil(tables.hasKeys)
  end)

  it("can merge tables", function()
    assert.not_nil(tables.merge)
  end)

  it("has all the api functions we expect", function()
    assert.is_function(tables.all)
    assert.is_function(tables.any)
    assert.is_function(tables.assign)
    assert.is_function(tables.concatArray)
    assert.is_function(tables.copyKeys)
    assert.is_function(tables.countBy)
    assert.is_function(tables.countKeys)
    assert.is_function(tables.findFirst)
    assert.is_function(tables.groupBy)
    assert.is_function(tables.hasKeys)
    assert.is_function(tables.indexed)
    assert.is_function(tables.indexOf)
    assert.is_function(tables.isEmpty)
    assert.is_function(tables.join)
    assert.is_function(tables.keysToList)
    assert.is_function(tables.map)
    assert.is_function(tables.max)
    assert.is_function(tables.min)
    assert.is_function(tables.merge)
    assert.is_function(tables.pack)
    assert.is_function(tables.pickRandom)
    assert.is_function(tables.removeItem)
    assert.is_function(tables.select)
    assert.is_function(tables.shuffle)
    assert.is_function(tables.slice)
    assert.is_function(tables.sortBy)
    assert.is_function(tables.sum)
    assert.is_function(tables.toArray)
  end)

end)