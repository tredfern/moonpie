-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(moonpie)
  local styles = moonpie.styles
  styles.root = {
    padding = 10,
    font = moonpie.fonts.default.regular(10)
  }

  styles.button = {
    font = moonpie.fonts.default.regular(12),
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

  styles.button_small = {
    corner_radius_x = 3, corner_radius_y = 3,
    font = moonpie.fonts.default.regular(10),
    padding = { left = 15, right = 15, top = 6, bottom = 6 }
  }

  styles.h1 = { margin = 10, color = "primary", font = moonpie.fonts.headline.bold(28) }
  styles.h2 = { color = "primary", font = moonpie.fonts.headline.bold(24) }
  styles.h3 = { margin = 10, color = "primary", font = moonpie.fonts.headline.bold(18) }
end
