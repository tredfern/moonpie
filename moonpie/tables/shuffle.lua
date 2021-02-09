-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(array)
  for i = #array, 1, -1 do
    local j = love.math.random(i)
    local temp = array[i]
    array[i] = array[j]
    array[j] = temp
  end
  return array
end