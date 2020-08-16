-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local slice = require "moonpie.tables.slice"

return function(tbl)
  return slice(tbl, 1, #tbl)
end