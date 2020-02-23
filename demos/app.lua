-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local moonpie = require "moonpie"
local components = moonpie.ui.components
require "demos.popup_menu"

local app = {}
app.show_light = true

-- Each layout represents a different demo
-- cycle is an iterator that continuously loops through a set
app.layouts = moonpie.collections.iterators.cycle({
  { heading = "Text Demo", layout = require "demos.text_demo" },
  { heading = "Controls Demo", layout = require "demos.controls_demo" },
  { heading = "Image Demo", layout = require "demos.image_demo" },
  { heading = "Color Demo", layout = require "demos.color_demo" },
  { heading = "File Explorer", layout = require "demos.file_explorer" },
  { heading = "Textbox", layout = require "demos.textbox_demo" },
  { heading = "Icons", layout = require "demos.icon_demo" }
})

--
-- Get the next layout from the cycle and render the display
-- Calling moonpie.render is a hard refresh of everything.
-- A more elegant solution might be for each demo to refresh but
-- the header and footer to maintain their versions.
--
function app.render_next()
  local l = app.layouts()
  moonpie.render("ui", components.body({
    app.header(l.heading),
    l.layout(),
    app.footer()
  }))
end

--
-- A Button component with a click to trigger the render next method
--
function app.next_demo_button()
  return components.button({
    style = "button-primary",
    caption = "Next Demo",
    click = app.render_next
  })
end

--
-- A button to switch between the light and the dark
--
function app.choose_mode()
  return components.dropdown_menu({
    caption = "Switch Mode",
    options = {
      {
        caption = "Light Mode",
        click = function()
          moonpie.logger.debug("Light Mode Clicked")
          moonpie.ui.themes.light_mode(moonpie)
        end
      }, {
        caption = "Dark Mode",
        click = function()
          moonpie.logger.debug("Dark Mode Clicked")
          moonpie.ui.themes.dark_mode(moonpie)
        end
      }
    }
  })
end

--
-- A button the triggers quitting
--
function app.quit_button()
  return components.button({
    caption = "Quit",
    style = "button-warning",
    click = function()
      love.event.quit()
    end
  })
end


--
-- The header is a container that handles laying out
--  The Title
--  The Button Controls
--
function app.header(demo_title)
  return {
    {
      -- Some stylistic values
      padding = 10,
      background_color = "invert_background",

      -- The title
      components.h1({ text = "Moonpie for Love2D" }),

      -- the controls
      components.button_group({
        style = "align-right align-middle",
        margin = { right = 10 },
        buttons = {
          app.next_demo_button(),
          app.choose_mode(),
          app.quit_button()
        }
      })
    },
    -- A sub header that describes the specific demo
    {
      components.h3({ text = demo_title }),
    }
  }
end

--
-- Footer that currently does absolutely nothing
--
function app.footer()
  return {
    padding = { left = 10, right = 10, top = 2, bottom = 2 },
  }
end

return app
