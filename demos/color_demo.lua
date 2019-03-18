-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local moonpie = require "moonpie"
local components = moonpie.components

local function color_gradient(base_color, gradients)
  local t = {}
  for i = 1, gradients do
    t[i] = components.text({ padding = 10, text = tostring(i),
      background_color = moonpie.colors.lighten(base_color, 1 + ( i / 10))
    })
  end
  return t
end

return function()
  return {
    components.h3({ text = "Lighten the things" }),
    components.section({
      color_gradient(moonpie.colors.dark_lava, 20),
      color_gradient(moonpie.colors.purple, 20),
      color_gradient(moonpie.colors.avocado, 20),
    }),
  }
end
