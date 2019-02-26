-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(moonpie)
  moonpie.colors.light_shade = moonpie.colors.golden_sand
  moonpie.colors.light_accent = moonpie.colors.ghost
  moonpie.colors.main = moonpie.colors.brown_rust
  moonpie.colors.dark_accent = moonpie.colors.bitter
  moonpie.colors.dark_shade = moonpie.colors.blackcurrant

  moonpie.colors.button_default = moonpie.colors.gray_medium
  moonpie.colors.button_default_hover = moonpie.colors.light_gray
  moonpie.colors.button_text = moonpie.colors.white
  moonpie.colors.primary = moonpie.colors.main
  moonpie.colors.info = moonpie.colors.dark_shade
  moonpie.colors.success = moonpie.colors.asparagus
  moonpie.colors.warning = moonpie.colors.golden_bell
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
    }
  }

  moonpie.components.text.font = moonpie.fonts.default.regular(14)
  moonpie.components.header1.font = moonpie.fonts.headline.bold(32)
  moonpie.components.header2.font = moonpie.fonts.headline.bold(24)
  moonpie.components.header3.font = moonpie.fonts.headline.bold(20)
end
