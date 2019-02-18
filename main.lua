-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
--
-- Test/Demo for Moonpie
--

local moonpie = require "moonpie"
local gui
local elements = require "elements"

function love.load()
  gui = moonpie.renderer(
    elements.container("text-wrapper",
      {
        elements["text-border"]("text1", { text = "Hello World!", color = moonpie.colors.cyan }),
        elements.text("text2", { text = "And now for something completely different", color = moonpie.colors.blue }),
    }):on_hover( { background = { color = moonpie.colors.light_gray } } ),
    elements["funky-rect"]("rect1"),
    elements["funky-rect2"]("rect2")
  )
end

function love.update()
end

function love.draw()

  gui:paint()
  love.graphics.setColor({1, 1, 1, 1 })
  love.graphics.setLineWidth(3)
  love.graphics.rectangle("line", 100, 100, 150, 150)
end
