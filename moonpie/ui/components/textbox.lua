-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"
local str = require "moonpie.utility.string"

Component("textbox", function(props)
  local textview = Component.text({ id = "textbox_text", text = props.text })
  local tb = {
    textview
  }
  tb.keypressed = function(_, key)
    local t = str.insert(textview.text, tb.cursor_position(), key)
    textview:update({ text = t })
  end
  tb.get_text = function() return textview.text end
  tb.cursor_position = function() return string.len(textview.text) end
  return tb
end)