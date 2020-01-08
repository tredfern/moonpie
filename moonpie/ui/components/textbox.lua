-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"
local str = require "moonpie.utility.string"

local special_keys = {
  backspace = function(tb)
    local txt = tb:get_text()
    local c = tb:cursor_position()
    local f = string.sub(txt, 1, c - 1)
    local l = string.sub(txt, c + 1)
    tb:set_text(f .. l)
  end
}

Component("textbox", function(props)
  local textview = Component.text({ id = "textbox_text", text = props.text or "" })
  local tb = {
    textview
  }
  tb.textview = textview
  tb.maxlength = props.maxlength

  tb.keypressed = function(_, key)
    -- Handle special keyboard functionality
    if (special_keys[key]) then
      special_keys[key](tb)
      return
    end

    -- Append keypressed to the textbox
    if not tb.maxlength or tb.maxlength > string.len(tb.get_text()) then
      local t = str.insert(textview.text, tb.cursor_position(), key)
      textview:update({ text = t })
    end
  end

  tb.get_text = function() return textview.text end
  tb.set_text = function(_, t) textview:update({ text = t }) end
  tb.cursor_position = function() return string.len(textview.text) end

  return tb
end)