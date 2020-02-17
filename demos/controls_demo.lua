-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"

return function()
  return {
    { components.h2({ text = "Buttons" }) },
    {
      margin = 5,
      components.button({ caption = "Default" }),
      components.button({ style = "button_primary", caption = "Primary" }),
      components.button({ style = "button_info", caption = "Info" }),
      components.button({ style = "button_warning", caption = "Warning" }),
      components.button({ style = "button_success", caption = "Success" }),
      components.button({ style = "button_danger", caption = "Danger" }),
    },
    {
      margin = 5,
      components.button({ style = "button_small", caption = "Default" }),
      components.button({ style = "button_primary button_small", caption = "Primary" }),
      components.button({ style = "button_info button_small", caption = "Info" }),
      components.button({ style = "button_warning button_small", caption = "Warning" }),
      components.button({ style = "button_success button_small", caption = "Success" }),
      components.button({ style = "button_danger button_small", caption = "Danger" }),
    },
    components.hr(),
    { components.h2({ text = "Toggles" }) },
    {
      margin = 5,
      components.checkbox({ caption = "Option 1" }),
      components.checkbox({ caption = "Option 2", value = true }),
      components.checkbox({ caption = "Option 3" })
    },
    { components.h2({ text = "Lists" }) },
    {
      margin = 5,
      components.list({ border = 0, border_color = "accent", items = { "one", "two", "three" } }),
      components.list({ list_item_type = components.image,
        border = 0, border_color = "accent",
        items = {
          {
            display = "inline",
            components.image({ src = "assets/images/cat.jpg", width = 40, height = 40 }),
            components.text({ text = "CAT", margin = { left = 3 }, style = "align-middle" })
          },
          {
            display = "inline",
            components.image({ src = "assets/images/big.jpg", width = 40, height = 40 }),
            components.text({ text = "BIG", margin = { left = 3}, style = "align-middle" })
          },
        }
      })
    }
  }

end
