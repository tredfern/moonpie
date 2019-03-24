-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local moonpie = require "moonpie"
local components = moonpie.components

components("main_menu", function()
  local main_menu
  main_menu = {
    background_color = "light_accent",
    border = 4,
    border_color = "dark_shade",
    padding = 16,
    width = 300,
    height = 250,
    style = "align-center",
    {
      components.button({
        width = "100%",
        caption = "Resume",
        style = "button_default align-center",
        click = function()
          main_menu:hide()
        end
      })
    },
    {
      components.button({
        width = "100%",
        caption = "Quit",
        style = "button_danger align-center",
        click = function()
          love.event.quit()
        end
      })
    }
  }
  return main_menu
end)

moonpie.keyboard:hotkey("escape", function()
  moonpie.logger.debug("Rendering Main Menu")
  local menu = components.main_menu()
  moonpie.render("modal", menu)
end)
