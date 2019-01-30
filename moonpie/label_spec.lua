-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Elements - Label", function()
  local Label = require "moonpie.label"
  local mock_love = require "test_helpers.mock_love"

  describe("initializing label", function()
    it("returns a function to draw the label", function()
      local l = Label()
      assert.equals("function", type(l))
    end)
  end)

  describe("rendering", function()
    it("draws the text out to the screen", function()
      mock_love.mock(love.graphics, "print", spy.new(function() end))
      local l = Label{ text = "Hello World!" }
      l()
      assert.spy(love.graphics.print).was.called_with("Hello World!")
    end)
  end)

end)
