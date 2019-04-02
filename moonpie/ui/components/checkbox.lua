-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"

local function get_check(v)
  return v and "√" or ""
end

Component("checkbox", function(props)
  return {
    value = props.value or false,
    render = function(self)
      return Component.section({
        Component.text{ id = "cb_check", text = get_check(self.value), style = "checkbox_box" },
        Component.text{ id = "cb_label", text = props.caption, style = "checkbox_label" },
      })
    end,
    click = function(self)
      self:update{ value = not self.value }
    end
  }
end)
