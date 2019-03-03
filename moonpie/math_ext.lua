-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local math_ext = {}

function math_ext.clamp(v, min, max)
  return (v < min and min) or (v > max and max) or v
end

return math_ext
