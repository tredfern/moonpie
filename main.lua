-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
--
-- Test/Demo for Moonpie
--

local moonpie = require "moonpie"
local app = moonpie.component:new()

function love.load()
  app:update(
    moonpie.label{ text = "Hello World!" }
  )
end

function love.update()
end

function love.draw()
  app:render()
end
