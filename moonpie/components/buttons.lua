-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local Component = require(BASE .. "component")

Component.text("button", {
  background_color = "button_default",
  color = "button_text",
  corner_radius_x = 4, corner_radius_y = 4,
  padding = { left = 30, right = 30, top = 12, bottom = 12 },
  margin = { left = 1, right = 1, top = 5, bottom = 5 },
  display = "inline",

  border = 1,
  border_color = "button_text"
}):on_hover({
  background_color = "button_default_hover",
  color = "dark_accent"
})

Component.button("button_primary", {
  background_color = "primary"
})

return Component.button("arrow_up_button", {
})