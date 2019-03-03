-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl, count)
  local i = #tbl + 1
  local last = 0
  if count then
    last = #tbl - count
  end

  return function()
    i = i - 1
    if i == last then return nil end
    return tbl[i]
  end
end
