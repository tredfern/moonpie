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
      components.button({ style = "button-primary", caption = "Primary" }),
      components.button({ style = "button-info", caption = "Info" }),
      components.button({ style = "button-warning", caption = "Warning" }),
      components.button({ style = "button-success", caption = "Success" }),
      components.button({ style = "button-danger", caption = "Danger" }),
    },
    {
      margin = 5,
      components.button({ style = "button-small", caption = "Default" }),
      components.button({ style = "button-primary button-small", caption = "Primary" }),
      components.button({ style = "button-info button-small", caption = "Info" }),
      components.button({ style = "button-warning button-small", caption = "Warning" }),
      components.button({ style = "button-success button-small", caption = "Success" }),
      components.button({ style = "button-danger button-small", caption = "Danger" }),
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
      components.list({ border = 0, borderColor = "accent", items = { "one", "two", "three" } }),
      components.list({ list_item_type = components.image,
        border = 0, borderColor = "accent",
        items = {
          {
            display = "inline",
            components.image({ source = "assets/images/cat.jpg", width = 40, height = 40 }),
            components.text({ text = "CAT", margin = { left = 3 }, style = "align-middle" })
          },
          {
            display = "inline",
            components.image({ source = "assets/images/big.jpg", width = 40, height = 40 }),
            components.text({ text = "BIG", margin = { left = 3}, style = "align-middle" })
          },
        }
      })
    },
    {
      margin = 5,
      components.progress_bar { maximum = 100, current = 28 }
    },
    {
      margin = 5,
      components.icon({ style = "icon-xsmall", icon = "acrobatic", color = "blue" }),
      components.icon({ style = "icon-small", icon = "acrobatic", color = "green" }),
      components.icon({ style = "icon-medium", icon = "acrobatic", color = "purple" }),
      components.icon({ style = "icon-large", icon = "acrobatic", color = "pink" }),
      components.icon({ style = "icon-xlarge", icon = "acrobatic", color = "silver" }),
    }
  }

end
