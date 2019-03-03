-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local UnionFind = {}

function UnionFind:new()
  local uf = {
    tree_size = {}
  }

  setmetatable(uf, self)
  self.__index = self
  return uf
end

function UnionFind:union(x, y)
  local rootX = self:find(x)
  local rootY = self:find(y)
  self:merge_trees(rootX, rootY)
end

function UnionFind:merge_trees(x, y)
  -- Use weighting based on the size of the tree
  if self.tree_size[x] > self.tree_size[y] then
    self[y] = x
    self.tree_size[x] = self.tree_size[x] + self.tree_size[y]
  else
    self[x] = y
    self.tree_size[y] = self.tree_size[y] + self.tree_size[x]
  end
end

function UnionFind:find(x)
  -- If it doesn't exist let's add it
  if self[x] == nil then
    self:add(x)
  end

  if self[x] == x then
    return x
  else
    return self:find(self[x])
  end
end

function UnionFind:connected(ref1, ref2)
  -- find if they have the same root
  return self:find(ref1) == self:find(ref2)
end

function UnionFind:add(x)
  if self[x] == nil then
    self[x] = x
    self.tree_size[x] = 1
  end
end

return UnionFind
