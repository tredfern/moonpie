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
moonpie.element.base("text-border", { display = "inline",
  color = moonpie.colors.white,
  border_color = moonpie.colors.blue_bell, border = 4, margin = 4, padding = 4 })
moonpie.element("funky-rect", { width = 20, height = 200, background_color = moonpie.colors.fuchsia_crayola })
  :on_hover({ background_color = moonpie.colors.green })
moonpie.element("funky-rect2", { width = 200, height = 20, background_color = moonpie.colors.yellow })
moonpie.element("container", { margin = 5, padding = 10, background_color = moonpie.colors.black })
moonpie.element.base("button", {
  display = "inline",
  color = moonpie.colors.white,
  background_color = moonpie.colors.blue_green,
  border = 1,
  border_color = moonpie.colors.light_gray,
  padding = 5,
  margin = 2,
}):on_hover({
  background_color = moonpie.colors.orange
})

return moonpie.element
