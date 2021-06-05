-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl, i, j)
  tbl[i], tbl[j] = tbl[j], tbl[i]
end