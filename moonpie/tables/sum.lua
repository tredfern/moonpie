-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function default_calc(v)
  return v
end

return function(table, calc)
  calc = calc or default_calc
  local sum = 0

  for _, v in ipairs(table) do
    sum = sum + calc(v)
  end

  return sum
end