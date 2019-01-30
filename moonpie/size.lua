-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local size = {}

function size:new(width, height)
  return {
    width = width,
    height = height
  }
end

return size
