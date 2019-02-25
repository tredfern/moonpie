-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local Component = require(BASE .. "component")

Component.text("button", {
  background_color = "button_default",
  color = "button_text",
  padding = 4,
  display = "inline"
}):on_hover({
  background_color = "button_default_hover",
  color = "dark_accent"
})

return Component.button("arrow_up_button", {
})
