-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.components"

return function()
  local lorem = love.filesystem.read("lorem_ipsum.txt")
  return {
    {
      border = 1, border_color = "gray",
      components.text({ text = lorem, padding = 5 }),
    },
    {
      {
        border = 1, border_color = "gray",
        width = "33.33%",
        components.text({ text = lorem, padding = 5 }),
      },
      {
        border = 1, border_color = "gray",
        width = "33.33%",
        components.text({ text = lorem, padding = 5 }),
      },
      {
        border = 1, border_color = "gray",
        width = "33.33%",
        components.text({ text = lorem, padding = 5 }),
      }
    }
  }
end
