-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
--
-- Test/Demo for Moonpie
--

local moonpie = require "moonpie"
local components = moonpie.components
local lorem = love.filesystem.read("lorem_ipsum.txt")
local show_light = true
local current_layout = 1
local layouts

function love.load()
  layouts[current_layout]()
end

function love.update()
  moonpie.update()
end

function love.draw()
  moonpie.paint()
end

local function header()
  return components.header1("h1", { text = "Moonpie for Love2D",
      components.button_group("group1", { align = "right",
        components.button_primary("next", { text = "Next Demo" }):on_click(function()
          current_layout = current_layout + 1
          layouts[current_layout]()
        end):on_hover({ background_color = moonpie.colors(function()
          return moonpie.colors.lighten(moonpie.colors("primary"), 1.2)
        end) }),
        components.button("btn1", { text = "Switch Mode" }):on_click(function()
          if show_light then
            moonpie.themes.dark_mode(moonpie)
          else
            moonpie.themes.light_mode(moonpie)
          end
          show_light = not show_light
        end)
      })
    })
end

local function text_layout()
  moonpie.layout({
    header(),
    components.header3({ text = "Long Text Demo" }),
    components.text({ text = lorem, padding = 5 }),
  })
end

local function button_layout()
  moonpie.layout({
    header(),
    components.header3({ text = "Buttons" }),
    components.button_group({
      margin = 5,
      components.button({ text = "Default" }),
      components.button_primary({ text = "Primary" }),
      components.button_info({ text = "Info" }),
      components.button_success({ text = "Success" }),
      components.button_warning({ text = "Warning" }),
      components.button_danger({ text = "Danger" })
    })
  })
end


layouts = {
  text_layout,
  button_layout,
}

