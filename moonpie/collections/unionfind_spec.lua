-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("UnionFind", function()
  local UnionFind = require "moonpie.collections.unionfind"
  it("can union two objects together", function()
    local uf = UnionFind:new()
    uf:union(1, 2)
    uf:union(3, 4)
  end)

  it("can find the root of the tree", function()
    local uf = UnionFind:new()
    uf:union(1, 2)
    assert.equals(2, uf:find(1))
    assert.equals(2, uf:find(2))
    uf:union(2, 5)
    assert.equals(2, uf:find(5))
    assert.equals(2, uf:find(5))
  end)

  it("can detect whether objects are unioned together", function()
    local uf = UnionFind:new()
    uf:union(1, 2)
    uf:union(2, 3)
    assert.is_true(uf:connected(1, 3))
  end)

  it("can work with any objects", function()
    local uf = UnionFind:new()
    uf:union("foo", "bar")
    uf:union("bar", "snafu")
    uf:union("foo", 5)
    assert.is_true(uf:connected("foo", 5))
    assert.is_true(uf:connected(5, "snafu"))
    assert.is_true(uf:connected("bar", "foo"))
  end)

  it("tracks the size of the tree to ensure that it maintains the shortest tree possible", function()
    local uf = UnionFind:new()
    uf:union(2, 3)
    assert.equals(3, uf:find(2))
    uf:union(2, 4)
    assert.equals(3, uf:find(4))
    uf:union(7, 8)
    uf:union(6, 8)
    uf:union(9, 8)
    uf:union(10, 8)
    uf:union(8, 2)
    assert.equals(8, uf:find(2))
  end)
end)
