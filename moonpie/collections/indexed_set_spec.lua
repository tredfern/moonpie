-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.collections.indexed_set", function()
  local indexed_set = require "moonpie.collections.indexed_set"

  it("can add items to the set, placing them at the end", function()
    local s = indexed_set:new()
    s:add(1)
    assert.equals(1, #s)
    assert.equals(1, s[1])
    s:add(2)
    assert.equals(2, #s)
    assert.equals(2, s[2])
  end)

  it("can add multiple items at a time", function()
    local s = indexed_set:new()
    s:add(1, 2, 3, 4, 5, 6)
    assert.equals(6, #s)
  end)

  it("tracks the index of values", function()
    local first = {}
    local second = {}
    local s = indexed_set:new()
    s:add(first, second)
    assert.equals(1, s.indices[first])
    assert.equals(2, s.indices[second])
  end)

  it("removes an entry by taking the last item and replacing with the existing item", function()
    local a, b, c, d = {}, {}, {}, {}
    local set = indexed_set:new()
    set:add(a, b, c, d)
    set:remove(b)
    assert.equals(d, set[2])
    assert.equals(2, set.indices[d])
    assert.equals(3, #set)
    assert.is_nil(set.indices[b])
  end)

  it("does not add duplicate values", function()
    local set = indexed_set:new()
    local a = {}
    set:add(a)
    assert.has_errors(
      function() set:add(a) end
    )
  end)

  it("can detect that it contains a key", function()
    local set = indexed_set:new()
    local a = {}
    set:add(a)
    assert.is_true(set:contains(a))
  end)
end)