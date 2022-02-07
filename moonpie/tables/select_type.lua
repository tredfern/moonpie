-- Copyright (c) 2022 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl, t)
  local select = require "moonpie.tables.select"
  return select(tbl, function(v) return type(v) == t end)
end