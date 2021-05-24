-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl, key, default)
  if tbl[key] == nil then
    tbl[key] = default
  end
end