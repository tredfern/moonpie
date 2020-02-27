-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = {}
tables.copy_keys = require "moonpie.utility.tables.copy_keys"
tables.has_keys = require "moonpie.utility.tables.has_keys"
tables.map = require "moonpie.utility.tables.map"
tables.merge = require "moonpie.utility.tables.merge"

function tables.pick_random(tbl)
  return tbl[ love.math.random(#tbl) ]
end
return tables