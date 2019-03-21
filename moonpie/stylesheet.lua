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

  styles.root = { }
  styles.body = { background_color = "background", color = "text", height = "100%" }
  styles.image = { color = { 1, 1, 1, 1 } }
  styles.text = { display = "inline" }

  styles.button = {
    font = moonpie.fonts.default.bold(12),
    background_color = "button_default",
    color = "button_text",
    corner_radius_x = 4, corner_radius_y = 4,
    padding = { left = 12, right = 12, top = 8, bottom = 8 },
    margin = { left = 1, right = 1, top = 5, bottom = 5 },
    display = "inline",
    _hover_ = {
      background_color = function() return color.lighten(color("button_default"), button_lighten) end
    }
  }

  styles.button_small = {
    corner_radius_x = 3, corner_radius_y = 3,
    font = moonpie.fonts.default.regular(10),
    padding = { left = 8, right = 8, top = 4, bottom = 4 }
  }

  button_style("primary", "primary")
  button_style("info", "info")
  button_style("danger", "danger")
  button_style("warning", "warning")
  button_style("success", "success")

  styles.h1 = { margin = 10, color = "primary", font = moonpie.fonts.headline.bold(28) }
  styles.h2 = { margin = 10, color = "primary", font = moonpie.fonts.headline.bold(24) }
  styles.h3 = { margin = 10, color = "primary", font = moonpie.fonts.headline.bold(18) }

  styles["align-right"] = { align = "right" }
  styles["align-middle"] = { vertical_align = "middle" }

  styles.debug_panel = {
    height = "100%",
    opacity = 0.7,
    background_color = "black",
    padding = 10,
    font = moonpie.fonts.fixed.regular(10),
    color = "white"
  }

  styles.debug_tool = {
    background_color = "gray",
    padding = 4,
    margin = 2
  }
end
