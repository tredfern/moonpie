-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local moonpie = require("moonpie")

local fonts = {
  bebas = moonpie.font("fonts/BebasNeue/BebasNeue-Regular.ttf")
}

moonpie.components("base", { font = fonts.bebas(12) })
moonpie.components.base("text", { display = "inline", color = moonpie.colors.white })
moonpie.components.base("text-border", { display = "inline",
  color = moonpie.colors.white,
  border_color = moonpie.colors.blue_bell, border = 4, margin = 4, padding = 4 })
moonpie.components("funky-rect", { width = 20, height = 200, background_color = moonpie.colors.fuchsia_crayola })
  :on_hover({ background_color = moonpie.colors.green })
moonpie.components("funky-rect2", { width = 200, height = 20, background_color = moonpie.colors.yellow })
moonpie.components("container", { margin = 5, padding = 10, background_color = moonpie.colors.black })
assert(moonpie.components.button)

return moonpie.components
