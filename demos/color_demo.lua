-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local moonpie = require "moonpie"
local components = moonpie.components

components("color_sample", function(props)
  return {
    display = "inline",
    background_color = props.color,
    width = 20,
    height = 20
  }
end)

local function color_gradient(base_color, gradients)
  local t = {}
  for i = 1, gradients do
    t[i] = components.text({ padding = 10, text = tostring(i),
      background_color = moonpie.colors.lighten(base_color, 1 + ( i / 10))
    })
  end
  return t
end

local function color_display()
  local out = moonpie.collections.list:new()
  for _, v in ipairs(moonpie.colors.all()) do
    if moonpie.colors.is_color(v) then
      out:add(components.color_sample({ color = v }))
    end
  end
  return out
end

return function()
  return {
    {
      components.h3({ text = "Lighten the things" }),
      components.section({
        color_gradient(moonpie.colors.dark_lava, 20),
        color_gradient(moonpie.colors.purple, 20),
        color_gradient(moonpie.colors.avocado, 20),
      }),
    },
    {
      components.h3({ text = "Named color library" }),
      color_display()
    }
  }
end
