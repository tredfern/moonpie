-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Textbox", function()
  local Components = require "moonpie.ui.components"

  it("displays text to be edited in nonwrapped form", function()
    local tb = Components.textbox({ text = "foo" })
    local t = tb:findByID("textbox_text")
    assert.equals("foo", t.text)
    assert.equals("none", t.textwrap)
  end)

  it("sets a style to use to change the textbox text", function()
    local tb = Components.textbox({ text = "foo" })
    local t = tb:findByID("textbox_text")
    assert.contains("textbox_text", t.style)
  end)

  it("defaults to empty string if no text is passed in", function()
    local tb = Components.textbox()
    assert.equals("", tb:getText())
  end)

  it("has a cursor position for where text should edit that defaults to end of text", function()
    local tb = Components.textbox({ text = "goobar" })
    assert.equals(6, tb.cursorPosition())
  end)

  it("when it receives a keypress it inserts to the cursor position", function()
    local tb = Components.textbox({ text = "goobar" })
    tb:keyPressed("a")
    assert.equals("goobara", tb:getText())
  end)

  it("can set the text directly", function()
    local tb = Components.textbox({ text = "fam" })
    tb:setText("bam")
    assert.equals("bam", tb:getText())
    assert.is_true(tb.textview:hasUpdates())
  end)

  it("puts the cursor at the end when set_text is called", function()
    local tb = Components.textbox { }
    tb:setText("foobar")
    assert.equals(6, tb:cursorPosition())
    tb:setText("do not change position", true)
    assert.equals(6, tb:cursorPosition())
  end)

  it("can have a maximum size set", function()
    local tb = Components.textbox({ maxlength = 12 })
    for _=1,15 do
      tb:keyPressed("a")
    end
    assert.equals(12, string.len(tb:getText()))
  end)

  it("draws a cursor at the correct position based on width of text", function()
    local moonpie = require "moonpie"
    local mock_love = require "moonpie.test_helpers.mock_love"
    mock_love.mock(love.graphics, "line", spy.new(function() end))


    -- Mock font always returns 10 for width and height
    local render = moonpie.testRender(Components.textbox { id = "tb_test", text = "test" })
    local tb = render:findByID("tb_test")
    tb.font = mock_love.newFont()
    tb:drawComponent()

    assert.spy(love.graphics.line).was.called_with(10, 0, 10, 10)
  end)

  describe("Special Keys", function()
    it("deletes the character before the cursor when backspace is received", function()
      local tb = Components.textbox({ text = "Sandwich" })
      tb:keyPressed("backspace")
      assert.equals("Sandwic", tb:getText())
      tb:keyPressed("backspace")
      assert.equals("Sandwi", tb:getText())
    end)

    it("will insert a space", function()
      local tb = Components.textbox { text = "Test" }
      tb:keyPressed("space")
      tb:keyPressed("f")
      assert.equals("Test f", tb:getText())
    end)

    it("can capitalize characters", function()
      local mock_love = require "moonpie.test_helpers.mock_love"
      local tb = Components.textbox { text = "Test" }
      mock_love.simulate_key_down("lshift")
      tb:keyPressed("a")
      assert.equals("TestA", tb:getText())

      mock_love.simulate_key_down("rshift")
      tb:keyPressed("a")
      assert.equals("TestAA", tb:getText())
    end)

    it("changes the cursor position when the left and right arrow keys are pressed", function()
      local tb = Components.textbox { text = "hello" }
      tb:keyPressed("left")
      assert.equals(4, tb:cursorPosition())
      tb:keyPressed("left")
      assert.equals(3, tb:cursorPosition())
      tb:keyPressed("left")
      tb:keyPressed("left")
      tb:keyPressed("left")
      tb:keyPressed("left")
      tb:keyPressed("left")
      assert.equals(0, tb:cursorPosition())
      tb:keyPressed("right")
      tb:keyPressed("right")
      tb:keyPressed("right")
      tb:keyPressed("right")
      tb:keyPressed("right")
      tb:keyPressed("right")
      tb:keyPressed("right")
      assert.equals(5, tb:cursorPosition())
    end)
  end)

  it("has no problem setting the text to nil", function()
    local tb = Components.textbox()
    assert.has_no_errors(function() tb:setText(nil) end)
  end)

  it("triggers on update when setText is called", function()
    local cb = spy.new(function() end)
    local tb = Components.textbox { onUpdate = cb }
    tb:setText("Foobar")
    assert.spy(cb).was.called_with(tb, { text = "Foobar" })
  end)

end)