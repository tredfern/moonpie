-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local BASE = (...):match('(.-)[^%.]+$')
local Style = require(BASE .. "moonpie.style")

local fonts = {
  bebas = love.graphics.newFont("fonts/BebasNeue/BebasNeue-Regular.ttf")
}

Style("base", { font = fonts.bebas })
Style("text", { display = "inline", color = { 1, 1, 1, 1 } }, Style.base)
Style("funky-rect", { width = 20, height = 200, background = { color = { 1, 1, 0, 1 } } }, Style.base)
Style("funky-rect2", { width = 200, height = 20, background = { color = { 1, 1, 0, 1 } } }, Style.base)

return Style
