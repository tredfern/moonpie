-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = {}
tables.all = require "moonpie.utility.tables.all"
tables.any = require "moonpie.utility.tables.any"
tables.copy_keys = require "moonpie.utility.tables.copy_keys"
tables.has_keys = require "moonpie.utility.tables.has_keys"
tables.keys_to_list = require "moonpie.utility.tables.keys_to_list"
tables.map = require "moonpie.utility.tables.map"
tables.merge = require "moonpie.utility.tables.merge"
tables.select = require "moonpie.utility.tables.select"
tables.sum = require "moonpie.utility.tables.sum"

function tables.pick_random(tbl)
  return tbl[ love.math.random(#tbl) ]
end
return tables