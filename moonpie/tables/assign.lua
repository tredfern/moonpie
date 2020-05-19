-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local copy_keys = require "moonpie.tables.copy_keys"

return function(dest, ...)
  for _, v in ipairs({...}) do
    if type(v) == "table" then
      copy_keys(v, dest, true)
    end
  end
  return dest
end