-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl, start, last)
  start = start or 1
  last = last or #tbl
  if start < 0 then
    start = start + last + 1
  end
  local out = {}
  for i=start,last do
    out[#out +1] = tbl[i]
  end
  return out
end