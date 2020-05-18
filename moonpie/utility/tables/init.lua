-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = {
  all = require "moonpie.utility.tables.all",
  any = require "moonpie.utility.tables.any",
  assign = require "moonpie.utility.tables.assign",
  concat_array = require "moonpie.utility.tables.concat_array",
  copy_keys = require "moonpie.utility.tables.copy_keys",
  count_by = require "moonpie.utility.tables.count_by",
  group_by = require "moonpie.utility.tables.group_by",
  has_keys = require "moonpie.utility.tables.has_keys",
  keys_to_list = require "moonpie.utility.tables.keys_to_list",
  map = require "moonpie.utility.tables.map",
  merge = require "moonpie.utility.tables.merge",
  select = require "moonpie.utility.tables.select",
  sum = require "moonpie.utility.tables.sum",
  to_array = require "moonpie.utility.tables.to_array",
}

function tables.pick_random(tbl)
  return tbl[ love.math.random(#tbl) ]
end
return tables