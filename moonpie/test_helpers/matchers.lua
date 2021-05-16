-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local assert = require('luassert.assert')

local function in_range(_, args)
  local r1, r2 = args[1], args[2]
  
  if r1 > r2 then
    r1, r2 = r2, r1
  end

  return function(value)
    if type(value) ~= "number" then return false end
    return value >= r1 and value <= r2
  end
end

assert:register("matcher", "in_range", in_range)
