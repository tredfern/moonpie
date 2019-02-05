-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
--
-- Test/Demo for Moonpie
--

local moonpie = require "moonpie"
local fonts = {
  bebas = love.graphics.newFont("fonts/BebasNeue/BebasNeue-Regular.ttf")
}
local renderer

function love.load()
  renderer = moonpie.renderer(
    {
      { display = "inline", text = "Hello World!", font = fonts.bebas, color = { 0, 1, 1, 1 } },
      { display = "inline", text = "And now for something completely different",
        font = fonts.bebas, color = { 1, 0, 1, 1 } },
    },
    { width = 20, height = 200, background = { color = { 1, 1, 0, 1 } } },
    { width = 200, height = 20, background = { color = { 1, 0, 1, 1 } } }
  )
end

function love.update()
end

function love.draw()
  renderer:paint()
end
