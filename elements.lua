-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local BASE = (...):match('(.-)[^%.]+$')
local Element = require(BASE .. "moonpie.element")

local fonts = {
  bebas = love.graphics.newFont("fonts/BebasNeue/BebasNeue-Regular.ttf")
}

Element("base", { font = fonts.bebas })
Element.base("text", { display = "inline", color = { 1, 1, 1, 1 } })
Element("funky-rect", { width = 20, height = 200, background = { color = { 1, 1, 0, 1 } } })
Element("funky-rect2", { width = 200, height = 20, background = { color = { 1, 0, 1, 1 } } })

return Element
