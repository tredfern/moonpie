-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(align, min, max, size)
  if align == "right" then
    return max - size
  elseif align == "center" then
    return (max - min - size) / 2
  else
    return min
  end
end
