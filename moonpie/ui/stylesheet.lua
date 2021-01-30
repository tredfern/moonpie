-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(moonpie)
  local styles = moonpie.ui.styles
  local color = moonpie.graphics.colors
  local button_lighten = 1.2

  local function button_style(name, bg_color)
    local n = "button-"..name
    styles[n] = {
      background_color = bg_color,
      _hover_ = {
        background_color = function() return color.lighten(color(bg_color), button_lighten) end
      }
    }
  end

  styles.root = { }

  styles.body = {
    background_color = "background",
    color = "text",
    height = "100%",
    font_name = "default",
    font_size = 12
  }
  styles.image = { color = { 1, 1, 1, 1 } }
  styles.text = { display = "inline" }

  styles.button = {
    font_name = "default-bold",
    font_size = 14,
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

  styles["button-small"] = {
    corner_radius_x = 3, corner_radius_y = 3,
    font_name = "default-bold",
    font_size = 10,
    padding = { left = 8, right = 8, top = 4, bottom = 4 }
  }

  styles.checkbox = {
    padding = 2
  }
  styles.checkbox_box = {
    border = 1,
    border_color = "text",
    margin = { left = 0, right = 5, top = 0, bottom = 0 },
    width = 11, height = 11,
    color = "text"
  }

  styles.dropdown = {
    display = "inline"
  }

  styles.dropdown_menu = {
    display = "inline",
  }

  styles.dropdown_menu_content = {
    display = "inline",
    border = 1,
    border_color = "dark_accent",
    child_orientation = "vertical",
    background_color = "background",
  }

  styles.dropdown_menu_option = {
    display = "inline",
    padding = 10,
    color = "text",
    _hover_ = { background_color = "accent" }
  }

  styles.list = {
    display = "inline",
    padding = 3,
    child_orientation = "vertical"
  }

  styles.list_item = {
    display = "inline",
    padding = 1
  }


  button_style("primary", "primary")
  button_style("info", "info")
  button_style("danger", "danger")
  button_style("warning", "warning")
  button_style("success", "success")

  styles.h1 = { display = "block", margin = 10, color = "primary", font_name = "headline-bold", font_size = 28 }
  styles.h2 = { display = "block", margin = 10, color = "primary", font_name = "headline-bold", font_size = 24 }
  styles.h3 = { display = "block", margin = 10, color = "primary", font_name = "headline-bold", font_size = 18 }

  styles["align-center"] = { align = "center" }
  styles["align-right"] = { align = "right" }
  styles["align-middle"] = { vertical_align = "middle" }
  styles["align-bottom"] = { vertical_align = "bottom" }

  styles.progress_bar = {
    border = 1,
    border_color = "dark_accent",
    width = "100%",
    height = 25
  }

  styles.debug_panel = {
    height = "100%",
    opacity = 0.7,
    background_color = "black",
    padding = 10,
    font_name = "fixed",
    font_size = 10,
    color = "white"
  }

  styles.debug_tool = {
    background_color = "gray",
    padding = 4,
    margin = 2,
  }

  styles.textbox = {
    border = 2,
    border_color = "gray",
    corner_radius_x = 2,
    corner_radius_y = 2,
    display = "inline",
    padding = 3
  }

  styles.hr = {
    height = 2,
    width = "98%",
    background_color = "text",
    align = "center"
  }

  styles["icon-xsmall"] = {
    width = 16, height = 16
  }
  styles["icon-small"] = {
    width = 24, height = 24
  }
  styles["icon-medium"] = {
    width = 32, height = 32
  }
  styles["icon-large"] = {
    width = 64, height = 64
  }
  styles["icon-xlarge"] = {
    width = 128, height = 128
  }
end
