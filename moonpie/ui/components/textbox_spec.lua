-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Textbox", function()
  local Components = require "moonpie.ui.components"

  it("displays text to be edited", function()
    local tb = Components.textbox({ text = "foo" })
    local t = tb:find_by_id("textbox_text")
    assert.equals("foo", t.text)
  end)

  it("has a cursor position for where text should edit that defaults to end of text", function()
    local tb = Components.textbox({ text = "goobar" })
    assert.equals(6, tb.cursor_position())
  end)

  it("when it receives a keypress it inserts to the cursor position", function()
    local tb = Components.textbox({ text = "goobar" })
    tb:keypressed("a")
    assert.equals("goobara", tb:get_text())
  end)
end)