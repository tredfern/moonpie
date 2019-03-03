-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local path = select(1, ...):match(".+%.") or ""
local defaultCompare = require (path.."defaultsortcompare")

local ShellSort = function(set, compare)
  compare = compare or defaultCompare
  local n = #set
  local h = 1;
  while (h < n / 3) do
    h = 3 * h + 1;
  end

  while (h >=1 ) do
    for i=h + 1,n do
      local j = i
      while (j > h and compare(set[j], set[j-h])) do
        set[j], set[j-h] = set[j-h], set[j]
        j = j - h
      end
    end
    h = math.floor(h / 3)
  end

  return set
end

return ShellSort
