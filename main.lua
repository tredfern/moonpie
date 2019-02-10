-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
--
-- Test/Demo for Moonpie
--

local moonpie = require "moonpie"
local renderer
local elements = require "elements"

function love.load()
  renderer = moonpie.renderer(
    {
      elements.text("text1", { text = "Hello World!", color = { 0, 1, 1, 1 } }),
      elements.text("text2", { text = "And now for something completely different", color = { 1, 0, 1, 1 } }),
    },
    elements["funky-rect"]("rect1"),
    elements["funky-rect2"]("rect2")
  )
end

function love.update()
end

function love.draw()
  renderer:paint()
end
