-- Copyright (c) 2022 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Class = require "moonpie.class"
local tables = require "moonpie.tables"
local Array = Class("moonpie.collections.Array")

function Array:initialize(dimensions)
  self.dimensions = dimensions
end

function Array:ensureElement(args)
  for dim = 1, self.dimensions - 1 do
    if not self[args[dim]] then
      self[args[dim]] = {}
    end
  end
end

function Array:get(args)
  local v = self[args[1]]
  for dim = 2, self.dimensions do
    v = v[args[dim]]
  end
  return v
end

function Array:set(args)
  local value = args[#args]
  local v = self[args[1]]

  for dim = 2, self.dimensions - 1 do
    v = v[args[dim]]
  end
  v[args[self.dimensions]] = value
end

function Array:__call(...)
  -- get the values
  local args = tables.pack(...)
  self:ensureElement(args)

  if args.n == self.dimensions then
    return self:get(args)
  elseif args.n == self.dimensions + 1 then
    self:set(args)
  end
end

return Array