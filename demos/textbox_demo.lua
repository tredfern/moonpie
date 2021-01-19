-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local components = require "moonpie.ui.components"
local styles = require "moonpie.ui.styles"

styles.textbox_text = {
  color = "red",
  font_size = 28
}

return function()
  return {
      components.text({ text = "Single Line: "}),
      components.textbox({
        text = "Edit Me",
        width = 100,
        click = function(self) self:set_focus() end,
      })
  }
end
