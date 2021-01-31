-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local moonpie = require "moonpie"
local components = moonpie.ui.components

components("color_sample", function(props)
  return {
    display = "inline",
    backgroundColor = props.color,
    width = 20,
    height = 20,
    border = 1,
    borderColor = "black"
  }
end)

local function color_gradient(base_color, gradients)
  local t = {}
  for i = 1, gradients do
    t[i] = components.text({ padding = 10, text = tostring(i),
      backgroundColor = moonpie.graphics.colors.lighten(base_color, 1 + ( i / 10))
    })
  end
  return t
end

local function color_display()
  local out = moonpie.collections.list:new()
  for _, v in ipairs(moonpie.graphics.colors.all()) do
    if moonpie.graphics.colors.isColor(v) then
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
        color_gradient(moonpie.graphics.colors.dark_lava, 20),
        color_gradient(moonpie.graphics.colors.purple, 20),
        color_gradient(moonpie.graphics.colors.avocado, 20),
      }),
    },
    {
      components.h3({ text = "Named color library" }),
      color_display()
    }
  }
end
