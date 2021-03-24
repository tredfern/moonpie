-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local indexOf = require "moonpie.tables.index_of"

return function(tbl, item)
  local i = indexOf(tbl, item)
  table.remove(tbl, i)
  return tbl
end