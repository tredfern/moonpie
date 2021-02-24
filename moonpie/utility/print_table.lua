-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local inspect = require "moonpie.ext.inspect"

return function(tbl)
  return inspect(tbl)
end