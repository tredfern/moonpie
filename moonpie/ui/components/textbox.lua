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
    local txt = tb:getText()
    local c = tb:cursorPosition()
    local f = string.sub(txt, 1, c - 1)
    local l = string.sub(txt, c + 1)
    tb:setText(f .. l, true)
    tb:backCursor()
  end,
  lshift = function() end,
  rshift = function() end,
  left = function(tb)
    tb:backCursor()
  end,
  right = function(tb)
    tb:advanceCursor()
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
  local textview = Component.text {
    id = "textbox_text",
    text = props.text or "",
    textwrap = "none",
    style = "textbox_text"
  }
  local cursor = string.len(textview.text)
  local tb = {
    textview,
  }
  tb.textview = textview
  tb.maxlength = props.maxlength

  tb.keyPressed = function(_, key)
    -- Handle special keyboard functionality
    if (special_keys[key]) then
      special_keys[key](tb)
      return
    end

    -- Append keyPressed to the textbox
    if not tb.maxlength or tb.maxlength > string.len(tb.getText()) then
      local t = str.insert(textview.text, tb.cursorPosition(), get_character( key ))
      textview:update({ text = t })
      tb.advanceCursor()
      tb.triggerUpdate()
    end
  end

  tb.getText = function() return textview.text end
  tb.setText = function(_, t, skip_update)
    t = t or ""
    textview:update({ text = t })
    if not skip_update == true then
      cursor = string.len(t)
    end
    tb.triggerUpdate()
  end

  tb.cursorPosition = function()
    return cursor
  end
  tb.backCursor = function()
    cursor = cursor - 1
    cursor = mathext.clamp(cursor, 0, string.len(tb.getText()))
  end

  tb.advanceCursor = function()
    cursor = cursor + 1
    cursor = mathext.clamp(cursor, 0, string.len(tb.getText()))
  end

  tb.drawComponent = function()
    local font = require "moonpie.graphics.font"
    local f = font.pick(textview:getNode())
    local x = f:getWidth(
      string.sub(textview.text, 1, tb.cursorPosition())
    )
    love.graphics.setLineWidth(2)
    love.graphics.line(x, 0, x, f:getHeight())
  end

  tb.triggerUpdate = function()
    if tb.onUpdate then
      tb:onUpdate({ text = tb:getText() })
    end
  end

  return tb
end)