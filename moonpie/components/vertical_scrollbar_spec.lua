-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Vertical Scrollbar", function()
  local vert = require "moonpie.components.vertical_scrollbar"

  describe("Scrolling operations", function()
    it("if no minimum or maximum values are set they default to 0 and 100", function()
      local v = vert("new-vert-bar")
      assert.equals(0, v.minimum)
      assert.equals(100, v.maximum)
    end)

    it("defaults its increment to one", function()
      local v = vert("vert-bar")
      assert.equals(1, v.increment)
    end)

    it("defaults it's current value to the minimum", function()
      local v = vert("new-vert-bar", { minimum = 10, maximum = 1000 })
      assert.equals(10, v:current_position())
    end)

    it("can be incremented up or down", function()
      local v = vert("scroll-test")
      assert.equals(0, v:current_position())
      v:scroll_down()
      assert.equals(1, v:current_position())
    end)

    it("can be scrolled up", function()
      local v = vert("scroll-test")
      v:scroll_down()
      assert.equals(1, v:current_position())
      v:scroll_up()
      assert.equals(0, v:current_position())
    end)

    it("stays within it's range", function()
      local v = vert("scroll-test")
      v:scroll_up()
      v:scroll_up()
      v:scroll_up()
      v:scroll_up()
      v:scroll_up()
      v:scroll_up()
      assert.equals(0, v:current_position())
    end)

    it("can be set to a specific value", function()
      local v = vert("scrolling")
      v:set_position(43)
      assert.equals(43, v:current_position())
    end)

    it("stays in range if you set it outside the range", function()
      local v = vert("scrolling", { minimum = 54, maximum = 1042 })
      v:set_position(-3923)
      assert.equals(54, v:current_position())
      v:set_position(39284)
      assert.equals(1042, v:current_position())
    end)
  end)
end)
