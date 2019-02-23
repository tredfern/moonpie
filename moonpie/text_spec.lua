-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Elements - Text", function()
  local Text = require "moonpie.text"
  local Node = require "moonpie.node"
  local mock_love = require "test_helpers.mock_love"
  local parent = Node({ width = 100, height = 100 })
  parent:layout()

  describe("Layout", function()
    it("creates a text object that handles the layout and drawing", function()
      mock_love.mock(love.graphics, "newText", spy.new(function() return mock_love.text end))
      local t = Text{ text = "Foobar", font = mock_love.font }
      t:layout(parent)
      assert.equals(mock_love.text, t.text_image)
      assert.spy(love.graphics.newText).was.called.with(mock_love.font)
    end)

    it("tells the text_image to format the text based on the wrap limit and align to left", function()
      mock_love.text.setf = spy.new(function() end)
      local t = Text{ text = "Foobar", font = mock_love.font }
      t:layout(parent)
      assert.spy(mock_love.text.setf).was.called.with(mock_love.text, "Foobar", 100, "left")
    end)

    it("uses the text image for the dimensions of the area", function()
      mock_love.text.getDimensions = function() return 54, 86 end
      local t = Text{ text = "foobar", font = mock_love.font }
      t:layout(parent)
      assert.equals(54, t.box.content.width)
      assert.equals(86, t.box.content.height)
    end)

    it("uses whatever the default font is from love if no font is set on element", function()
      local t = Text{ text = "foobar" }
      mock_love.mock(love.graphics, "getFont", spy.new(function() return mock_love.font end))
      t:layout(parent)
      assert.spy(love.graphics.getFont).was.called()
    end)
  end)

  describe("painting", function()
    it("draws the text_image out to the screen", function()
      mock_love.mock(love.graphics, "draw", spy.new(function() end))
      local l = Text{ text = "Hello!" }
      l:layout(parent)
      l:paint()
      assert.spy(love.graphics.draw).was.called.with(l.text_image, 0, 0)
    end)

    describe("color management", function()
      mock_love.mock(love.graphics, "setColor", spy.new(function() end))

      it("sets the color if specified", function()
        local color = { 1, 1, 1, 1 }
        local l = Text{ text = "Foo", color =  color }
        l:paint()
        assert.spy(love.graphics.setColor).was.called_with(color)
      end)

      it("does not set the color if nil", function()
        local l = Text{ text = "foo" }
        l:paint()
        assert.spy(love.graphics.setColor).was_not.called_with(nil)
      end)
    end)
  end)
end)
