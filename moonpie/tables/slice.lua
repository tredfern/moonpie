-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl, start, last)
  start = start or 1
  last = last or #tbl
  local out = {}
  for i=start,last do
    out[#out +1] = tbl[i]
  end
  return out
end