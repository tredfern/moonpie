-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Conf = require "moonpie.configuration"

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
  local Font = moonpie.graphics.font
  Font:register(Conf.assets_path .. "/fonts/Roboto-Regular.ttf", "default")
  Font:register(Conf.assets_path .. "/fonts/Roboto-Bold.ttf", "default-bold")
  Font:register(Conf.assets_path .. "/fonts/RobotoSlab-Regular.ttf", "headline")
  Font:register(Conf.assets_path .. "/fonts/RobotoSlab-Bold.ttf", "headline-bold")
  Font:register(Conf.assets_path .. "/fonts/Hack-Regular.ttf", "fixed")
  Font:register(Conf.assets_path .. "/fonts/Hack-Bold.ttf", "fixed-bold")
  Font:register(Conf.assets_path .. "/fonts/uglyhandwriting.ttf", "not-set")

  assert(moonpie.graphics.colors.light_shade)
  assert(moonpie.graphics.colors.light_accent)
  assert(moonpie.graphics.colors.primary)
  assert(moonpie.graphics.colors.dark_accent)
  assert(moonpie.graphics.colors.dark_shade)
end
