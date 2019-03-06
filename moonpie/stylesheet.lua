-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local styles = require "moonpie.styles"


styles.button = {
  background_color = "button_default",
  color = "button_text",
  corner_radius_x = 4, corner_radius_y = 4,
  padding = { left = 30, right = 30, top = 12, bottom = 12 },
  margin = { left = 1, right = 1, top = 5, bottom = 5 },
  display = "inline",
}

styles.button_primary = { background_color = "primary" }
styles.button_info = { background_color = "info" }
styles.button_danger = { background_color = "danger" }
styles.button_success = { background_color = "success" }
styles.button_warning = { background_color = "warning" }
