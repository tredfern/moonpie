-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT



return function(moonpie)
  local styles = moonpie.styles
  local color = moonpie.colors
  local button_lighten = 1.2

  local function button_style(name, bg_color)
    local n = "button_"..name
    styles[n] = {
      background_color = bg_color,
      _hover_ = {
        background_color = function() return color.lighten(color(bg_color), button_lighten) end
      }
    }
  end

  styles.root = { background_color = "background", color = "text" }
  styles.image = { color = { 1, 1, 1, 1 } }

  styles.button = {
    font = moonpie.fonts.default.regular(12),
    background_color = "button_default",
    color = "button_text",
    corner_radius_x = 4, corner_radius_y = 4,
    padding = { left = 30, right = 30, top = 12, bottom = 12 },
    margin = { left = 1, right = 1, top = 5, bottom = 5 },
    display = "inline",
    _hover_ = {
      background_color = function() return color.lighten(color("button_default"), button_lighten) end
    }
  }

  button_style("primary", "primary")
  button_style("info", "info")
  button_style("danger", "danger")
  button_style("warning", "warning")
  button_style("success", "success")

  styles.button_small = {
    corner_radius_x = 3, corner_radius_y = 3,
    font = moonpie.fonts.default.regular(10),
    padding = { left = 15, right = 15, top = 6, bottom = 6 }
  }

  styles.h1 = { margin = 10, color = "primary", font = moonpie.fonts.headline.bold(28) }
  styles.h2 = { color = "primary", font = moonpie.fonts.headline.bold(24) }
  styles.h3 = { margin = 10, color = "primary", font = moonpie.fonts.headline.bold(18) }

  styles["align-right"] = { align = "right" }
end
