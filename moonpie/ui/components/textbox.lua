-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"
local str = require "moonpie.utility.string"
local keyboard = require "moonpie.keyboard"
local mathext = require "moonpie.math"

local special_keys = {
  backspace = function(tb)
    local txt = tb:get_text()
    local c = tb:cursor_position()
    local f = string.sub(txt, 1, c - 1)
    local l = string.sub(txt, c + 1)
    tb:set_text(f .. l, true)
    tb:back_cursor()
  end,
  lshift = function() end,
  rshift = function() end,
  left = function(tb)
    tb:back_cursor()
  end,
  right = function(tb)
    tb:advance_cursor()
  end
}

local function get_character(key)
  if key == "space" then
    return " "
  elseif keyboard.isDown("lshift") or keyboard.isDown("rshift") then
    return string.upper(key)
  else
    return key
  end
end

Component("textbox", function(props)
  local textview = Component.text({ id = "textbox_text", text = props.text or "", textwrap = "none" })
  local cursor = string.len(textview.text)
  local tb = {
    textview,
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
      local t = str.insert(textview.text, tb.cursor_position(), get_character( key ))
      textview:update({ text = t })
      tb.advance_cursor()
    end
  end

  tb.get_text = function() return textview.text end
  tb.set_text = function(_, t, skip_update)
    textview:update({ text = t })
    if not skip_update == true then
      cursor = string.len(t)
    end
  end

  tb.cursor_position = function()
    return cursor
  end
  tb.back_cursor = function()
    cursor = cursor - 1
    cursor = mathext.clamp(cursor, 0, string.len(tb.get_text()))
  end

  tb.advance_cursor = function()
    cursor = cursor + 1
    cursor = mathext.clamp(cursor, 0, string.len(tb.get_text()))
  end

  tb.draw_component = function(self)
    local font = require "moonpie.graphics.font"
    local f = font.pick(self)
    local x = f:getWidth(
      string.sub(textview.text, 1, tb.cursor_position())
    )
    love.graphics.setLineWidth(2)
    love.graphics.line(x, 0, x, f:getHeight())

  end

  return tb
end)