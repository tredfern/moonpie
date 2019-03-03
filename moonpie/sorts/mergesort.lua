-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local defaultcompare = require ("moonpie.sorts.defaultsortcompare")

local function merge(list, low, mid, high, compare)
  local i, j = low, mid + 1
  local result = {}
  for k=low,high do
    result[k] = list[k]
  end

  for k=low,high do
    if i > mid  then
      list[k] = result[j]
      j = j + 1
    elseif j > high then
      list[k] = result[i]
      i = i + 1
    elseif compare(result[i], result[j]) then
      list[k] = result[i]
      i = i + 1
    else
      list[k] = result[j]
      j = j + 1
    end
  end

  return list
end

local function sort(list, low, high, compare)
  if high <= low then return end
  local mid = low + math.floor((high - low) / 2)
  sort(list, low, mid, compare)
  sort(list, mid + 1, high, compare)
  return merge(list, low, mid, high, compare)
end



local MergeSort = function(list, compare)
  compare = compare or defaultcompare
  sort(list, 1, #list, compare)

  return list
end

return MergeSort
