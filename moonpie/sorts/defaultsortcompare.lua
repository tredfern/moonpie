-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local defaultCompare = function(a, b)
  if(b == nil) then return true end
  if(a == nil) then return false end
  return a <= b
end

return defaultCompare
