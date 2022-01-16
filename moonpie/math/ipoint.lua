-- Copyright (c) 2022 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local readOnly = require "moonpie.utility.read_only_table"
local iPoint = {}
local cache = {}

function iPoint.createHashKey(x, y, z)
  -- Credit for algorithm: https://dmauro.com/post/77011214305/a-hashing-function-for-x-y-z-coordinates
  x, y, z = x or 0, y or 0, z or 0
  if x >= 0 then x = 2 * x else x = -2 * x - 1 end
  if y >= 0 then y = 2 * y else y = -2 * y - 1 end
  if z >= 0 then z = 2 * z else z = -2 * z - 1 end

  local m = math.max(x, y, z)
  local hash = m^3 + (2 * m * z) + z
  if m == z then
    hash = hash + math.max(x, y)^2
  end

  if y >= x then
    hash = hash + x + y
  else
    hash = hash + y
  end
  return hash
end

function iPoint.checkCache(x, y, z)
  return cache[x] and cache[x][y] and cache[x][y][z]
end

function iPoint.cache(point)
  local x, y, z = point.x, point.y, point.z
  if cache[x] == nil then cache[x] = {} end
  if cache[x][y] == nil then cache[x][y] = {} end
  cache[x][y][z] = point
end

function iPoint.new(x, y, z)
  local p = iPoint.checkCache(x, y, z)
  if p then return p end

  p = readOnly {
    x = math.floor(x) or 0,
    y = math.floor(y) or 0,
    z = math.floor(z) or 0,
    hashKey = iPoint.createHashKey(x, y, z)
  }

  iPoint.cache(p)

  return p
end

function iPoint.add(pt, x, y, z)
  return iPoint.new(pt.x + x, pt.y + y, pt.z + z)
end

return setmetatable(iPoint, {
  __call = function(_, x, y, z)
    return iPoint.new(x, y, z)
  end
})