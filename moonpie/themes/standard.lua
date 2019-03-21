-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(moonpie)
  moonpie.colors.light_shade = moonpie.colors.pampas
  moonpie.colors.light_accent = moonpie.colors.burning_sand
  moonpie.colors.main = moonpie.colors.vin_rouge
  moonpie.colors.dark_accent = moonpie.colors.bouquet
  moonpie.colors.dark_shade = moonpie.colors.steel_gray

  moonpie.colors.button_default = moonpie.colors.gray_medium
  moonpie.colors.button_default_hover = moonpie.colors.light_gray
  moonpie.colors.button_text = moonpie.colors.white
  moonpie.colors.primary = moonpie.colors.main
  moonpie.colors.info = moonpie.colors.steel_gray
  moonpie.colors.success = moonpie.colors.highland
  moonpie.colors.warning = moonpie.colors.zest
  moonpie.colors.danger = moonpie.colors.pomegranate


  --TODO: More elegant solution for this
  moonpie.fonts = {
    default = {
      regular = moonpie.font("moonpie/assets/fonts/roboto/Regular.ttf"),
      bold = moonpie.font("moonpie/assets/fonts/roboto/Bold.ttf")
    },
    headline = {
      regular = moonpie.font("moonpie/assets/fonts/roboto_slab/Regular.ttf"),
      bold = moonpie.font("moonpie/assets/fonts/roboto_slab/Bold.ttf")
    },
    fixed = {
      regular = moonpie.font("moonpie/assets/fonts/hack/Regular.ttf"),
      bold = moonpie.font("moonpie/assets/fonts/hack/Bold.ttf")
    }
  }

  assert(moonpie.colors.light_shade)
  assert(moonpie.colors.light_accent)
  assert(moonpie.colors.primary)
  assert(moonpie.colors.dark_accent)
  assert(moonpie.colors.dark_shade)
end
