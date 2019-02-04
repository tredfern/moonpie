-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Elements - Text", function()
  local Text = require "moonpie.text"
  local mock_love = require "test_helpers.mock_love"

  describe("initializing text", function()
  end)

  describe("calculating box model", function()
    it("determines the width and height based on the font size", function()
      local l = Text{ text = "Hello World", font = mock_love.font }
      local cw, ch = l:content_size()
      assert.equals(mock_love.font:getWidth(), cw)
      assert.equals(mock_love.font:getHeight(), ch)
    end)
  end)

  describe("painting", function()
    it("draws the text out to the screen", function()
      mock_love.mock(love.graphics, "print", spy.new(function() end))
      local l = Text{ text = "Hello World!" }

      l.paint()

      assert.spy(love.graphics.print).was.called_with("Hello World!")
    end)

    describe("font management", function()
      mock_love.mock(love.graphics, "setFont", spy.new(function() end))

      it("changes the font if set", function()
        local l = Text{ text = "Foo", font = mock_love.font }

        l.paint()

        assert.spy(love.graphics.setFont).was.called_with(mock_love.font)
      end)

      it("does not set the font if font is nil", function()
        local l = Text{ text = "Foo" }
        l.paint()
        assert.spy(love.graphics.setFont).was_not.called_with(nil)
      end)
    end)

    describe("color management", function()
      mock_love.mock(love.graphics, "setColor", spy.new(function() end))

      it("sets the color if specified", function()
        local color = { 1, 1, 1, 1 }
        local l = Text{ text = "Foo", color =  color }
        l.paint()
        assert.spy(love.graphics.setColor).was.called_with(color)
      end)

      it("does not set the color if nil", function()
        local l = Text{ text = "foo" }
        l.paint()
        assert.spy(love.graphics.setColor).was_not.called_with(nil)
      end)
    end)
  end)
end)
