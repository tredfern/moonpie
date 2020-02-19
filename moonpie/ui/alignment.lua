-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(align, min, max, size)
  local pos
  if align == "right" or align == "bottom" then
    pos = max - size
  elseif align == "center" or align == "middle" then
    pos = (max - min - size) / 2
  else
    pos = min
  end
  return math.max(pos, min)
end
