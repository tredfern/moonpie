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
local app = moonpie.component:new{ background_color = { 1, 1, 1, 1 } }

function love.load()
  app:update(
    moonpie.text{ font = fonts.bebas, text = "Hello World!", color = { 0, 1, 1, 1 } }
  )
end

function love.update()
end

function love.draw()
  app:render()
end
