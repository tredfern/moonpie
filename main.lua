-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
--
-- Test/Demo for Moonpie
--

local moonpie = require "moonpie"
local components = require "components"
local lorem = love.filesystem.read("lorem_ipsum.txt")

function love.load()
  moonpie.layout(
    components.container("button-tests", {
      components.button("button1", { text = "Click Me!" })
        :on_click(function(self) self.text = "Clicked!" end),
      components.button("button1", { text = "Click Me 2!" })
        :on_click(function(self) self.text = "Clicked 2!" end)
    }),
    components.container("text-wrapper",
      {
        components["text-border"]("text1", { text = "Hello World!", color = moonpie.colors.cyan }),
        components.text("text2", { text = "And now for something completely different", color = moonpie.colors.blue }),
    }):on_hover( { background_color = moonpie.colors.light_gray }),
    components["funky-rect"]("rect1"),
    components["funky-rect2"]("rect2"),
    components.container("text-test",
    {
      components.text("long-text", { text = lorem })
    })
  )
end

function love.update()
  moonpie.update()
end

function love.draw()
  moonpie.paint()
end
