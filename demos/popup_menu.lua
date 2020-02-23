-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local moonpie = require "moonpie"
local components = moonpie.ui.components

components("main_menu", function()
  local main_menu
  main_menu = {
    background_color = "light_shade",
    border = 4,
    border_color = "dark_shade",
    padding = 16,
    width = 300,
    height = 250,
    style = "align-center align-middle",
    {
      components.h3({
        style = "align-center",
        text = "Main Menu"
      })
    },
    {
      components.button({
        width = "100%",
        caption = "Resume",
        style = "button-default align-center",
        click = function()
          main_menu:hide()
        end
      })
    },
    {
      components.button({
        width = "100%",
        caption = "Quit",
        style = "button-danger align-center",
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
