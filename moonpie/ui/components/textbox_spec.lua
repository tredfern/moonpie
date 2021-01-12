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

  it("defaults to empty string if no text is passed in", function()
    local tb = Components.textbox()
    assert.equals("", tb:get_text())
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

  it("can set the text directly", function()
    local tb = Components.textbox({ text = "fam" })
    tb:set_text("bam")
    assert.equals("bam", tb:get_text())
    assert.is_true(tb.textview:has_updates())
  end)

  it("can have a maximum size set", function()
    local tb = Components.textbox({ maxlength = 12 })
    for _=1,15 do
      tb:keypressed("a")
    end
    assert.equals(12, string.len(tb:get_text()))
  end)

  describe("Special Keys", function()
    it("deletes the character before the cursor when backspace is received", function()
      local tb = Components.textbox({ text = "Sandwich" })
      tb:keypressed("backspace")
      assert.equals("Sandwic", tb:get_text())
      tb:keypressed("backspace")
      assert.equals("Sandwi", tb:get_text())
    end)

    it("will insert a space", function()
      local tb = Components.textbox { text = "Test" }
      tb:keypressed("space")
      tb:keypressed("f")
      assert.equals("Test f", tb:get_text())
    end)

    it("can capitalize characters", function()
      local mock_love = require "moonpie.test_helpers.mock_love"
      local tb = Components.textbox { text = "Test" }
      mock_love.simulate_key_down("lshift")
      tb:keypressed("a")
      assert.equals("TestA", tb:get_text())

      mock_love.simulate_key_down("rshift")
      tb:keypressed("a")
      assert.equals("TestAA", tb:get_text())
    end)
  end)

end)