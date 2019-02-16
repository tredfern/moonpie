-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local moonpie = require("moonpie")

local fonts = {
  bebas = love.graphics.newFont("fonts/BebasNeue/BebasNeue-Regular.ttf")
}

moonpie.element("base", { font = fonts.bebas })
moonpie.element.base("text", { display = "inline", color = moonpie.colors.white })
moonpie.element("funky-rect", { width = 20, height = 200, background = { color = moonpie.colors.fuchsia_crayola } })
  :on_hover({ background = { color = moonpie.colors.green } })
moonpie.element("funky-rect2", { width = 200, height = 20, background = { color = moonpie.colors.yellow } })

return moonpie.element
