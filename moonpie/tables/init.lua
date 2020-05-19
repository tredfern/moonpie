-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = {
  all = require "moonpie.tables.all",
  any = require "moonpie.tables.any",
  assign = require "moonpie.tables.assign",
  concat_array = require "moonpie.tables.concat_array",
  copy_keys = require "moonpie.tables.copy_keys",
  count_by = require "moonpie.tables.count_by",
  group_by = require "moonpie.tables.group_by",
  has_keys = require "moonpie.tables.has_keys",
  keys_to_list = require "moonpie.tables.keys_to_list",
  map = require "moonpie.tables.map",
  merge = require "moonpie.tables.merge",
  select = require "moonpie.tables.select",
  sum = require "moonpie.tables.sum",
  to_array = require "moonpie.tables.to_array",
}

function tables.pick_random(tbl)
  return tbl[ love.math.random(#tbl) ]
end
return tables