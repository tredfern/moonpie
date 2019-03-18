-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.components"

return function()
  local lorem = love.filesystem.read("lorem_ipsum.txt")
  return {
    components.text({ text = lorem, padding = 5 }),
  }
end
