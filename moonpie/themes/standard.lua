-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Conf = require "moonpie.conf"

return function(moonpie)
  moonpie.graphics.colors.light_shade = moonpie.graphics.colors.pampas
  moonpie.graphics.colors.light_accent = moonpie.graphics.colors.burning_sand
  moonpie.graphics.colors.main = moonpie.graphics.colors.vin_rouge
  moonpie.graphics.colors.dark_accent = moonpie.graphics.colors.bouquet
  moonpie.graphics.colors.dark_shade = moonpie.graphics.colors.steel_gray

  moonpie.graphics.colors.button_default = moonpie.graphics.colors.gray_medium
  moonpie.graphics.colors.button_default_hover = moonpie.graphics.colors.light_gray
  moonpie.graphics.colors.button_text = moonpie.graphics.colors.white
  moonpie.graphics.colors.primary = moonpie.graphics.colors.main
  moonpie.graphics.colors.info = moonpie.graphics.colors.steel_gray
  moonpie.graphics.colors.success = moonpie.graphics.colors.highland
  moonpie.graphics.colors.warning = moonpie.graphics.colors.zest
  moonpie.graphics.colors.danger = moonpie.graphics.colors.pomegranate


  --TODO: More elegant solution for this
  moonpie.graphics.fonts = {
    default = {
      regular = moonpie.graphics.font(Conf.assets_path .. "fonts/roboto/Regular.ttf"),
      bold = moonpie.graphics.font(Conf.assets_path .. "fonts/roboto/Bold.ttf")
    },
    headline = {
      regular = moonpie.graphics.font(Conf.assets_path .. "fonts/roboto_slab/Regular.ttf"),
      bold = moonpie.graphics.font(Conf.assets_path .. "fonts/roboto_slab/Bold.ttf")
    },
    fixed = {
      regular = moonpie.graphics.font(Conf.assets_path .. "fonts/hack/Regular.ttf"),
      bold = moonpie.graphics.font(Conf.assets_path .. "fonts/hack/Bold.ttf")
    }
  }

  assert(moonpie.graphics.colors.light_shade)
  assert(moonpie.graphics.colors.light_accent)
  assert(moonpie.graphics.colors.primary)
  assert(moonpie.graphics.colors.dark_accent)
  assert(moonpie.graphics.colors.dark_shade)
end
