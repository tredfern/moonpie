-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(tbl)
  return setmetatable({ }, {
    __index = tbl,
    __newindex = function() error("Table is immutable") end
  })
end