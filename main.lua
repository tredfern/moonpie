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

local function header(props)
  return {
    components.section({
      components.h1({ text = "Moonpie for Love2D" }),
      components.button_group({ align = "right",
        components.button({
          style = "button_primary",
          caption = "Next Demo",
          click = function()
            current_layout = current_layout + 1
            layouts[current_layout]()
          end
        }),
        components.button({
          caption = "Switch Mode",
          click = function()
            if show_light then
              moonpie.themes.dark_mode(moonpie)
            else
              moonpie.themes.light_mode(moonpie)
            end
            show_light = not show_light
          end
        })
      })
    }),
    components.section({
      components.h3({ text = props }),
    }),
  }
end

local function text_layout()
  moonpie.layout({
    header("Long Text Demo"),
    components.section({
      components.text({ text = lorem, padding = 5 }),
    })
  })
end

local function button_layout()
  moonpie.layout({
    header("Buttons"),
    components.button_group({
      margin = 5,
      components.button({ caption = "Default" }),
      components.button({ style = "button_primary", caption = "Primary" }),
      components.button({ style = "button_info", caption = "Info" }),
      components.button({ style = "button_warning", caption = "Warning" }),
      components.button({ style = "button_success", caption = "Success" }),
      components.button({ style = "button_danger", caption = "Danger" }),
    }),
    components.button_group({
      margin = 5,
      components.button({ style = "button_small", caption = "Default" }),
      components.button({ style = "button_primary button_small", caption = "Primary" }),
      components.button({ style = "button_info button_small", caption = "Info" }),
      components.button({ style = "button_warning button_small", caption = "Warning" }),
      components.button({ style = "button_success button_small", caption = "Success" }),
      components.button({ style = "button_danger button_small", caption = "Danger" }),
    }),
  })
end


layouts = {
  text_layout,
  button_layout,
}

