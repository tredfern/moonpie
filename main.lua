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

function love.load()
  moonpie.layout({
    components.header1("h1", { text = "UI Test Bed",
      components.button("btn1", { text = "Switch Mode", align="right" }):on_click(function()
        if show_light then
          moonpie.themes.dark_mode(moonpie)
        else
          moonpie.themes.light_mode(moonpie)
        end
        show_light = not show_light
      end)
    }),
    components.header1("h2", { text = "Big Text" }),
    components.text("lorem", { text = lorem, padding = 5 })
  })
end

function love.update()
  moonpie.update()
end

function love.draw()
  moonpie.paint()
end
