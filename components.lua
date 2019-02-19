-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local moonpie = require("moonpie")

local fonts = {
  bebas = love.graphics.newFont("fonts/BebasNeue/BebasNeue-Regular.ttf")
}

moonpie.component("base", { font = fonts.bebas })
moonpie.component.base("text", { display = "inline", color = moonpie.colors.white })
moonpie.component.base("text-border", { display = "inline",
  color = moonpie.colors.white,
  border_color = moonpie.colors.blue_bell, border = 4, margin = 4, padding = 4 })
moonpie.component("funky-rect", { width = 20, height = 200, background_color = moonpie.colors.fuchsia_crayola })
  :on_hover({ background_color = moonpie.colors.green })
moonpie.component("funky-rect2", { width = 200, height = 20, background_color = moonpie.colors.yellow })
moonpie.component("container", { margin = 5, padding = 10, background_color = moonpie.colors.black })
moonpie.component.base("button", {
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

return moonpie.component
