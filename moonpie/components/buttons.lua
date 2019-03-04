-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require("moonpie.components.component")

Component("button", function(props)
  return {
    background_color = "button_default",
    color = "button_text",
    corner_radius_x = 4, corner_radius_y = 4,
    padding = { left = 30, right = 30, top = 12, bottom = 12 },
    margin = { left = 1, right = 1, top = 5, bottom = 5 },
    display = "inline",
    click = props.click,
    Component.text({ text = props.caption })
  }
end)

Component("button_group", { display = "inline" })
