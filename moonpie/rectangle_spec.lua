-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Rectangle", function()
  local rectangle = require "moonpie.rectangle"

  describe("initialization", function()
    local test_rect = rectangle:new{x = 9, y = 48, width = 102, height = 150 }

    it("can be set up by x, y, width, height properties", function()
      assert.equals(9, test_rect.x)
      assert.equals(48, test_rect.y)
      assert.equals(102, test_rect.width)
      assert.equals(150, test_rect.height)
    end)

    it("can calculate the left, top, right, bottom values", function()
      assert.equals(9, test_rect:left())
      assert.equals(48, test_rect:top())
      assert.equals(111, test_rect:right())
      assert.equals(198, test_rect:bottom())
    end)

    describe("no parameters", function()
      local empty = rectangle:new()
      it("all zeros", function()
        assert.equals(0, empty.x)
        assert.equals(0, empty.y)
        assert.equals(0, empty.width)
        assert.equals(0, empty.height)
      end)
    end)
  end)

  describe("call metamethod", function()
    it("constructs a new instance of rectangle", function()
      local test = rectangle{ x = 29, y = 39, width = 10, height = 39}
      assert.equals(29, test:left())
      assert.equals(78, test:bottom())
    end)
  end)
end)
