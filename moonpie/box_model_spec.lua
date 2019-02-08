-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Box Model", function()
  local box_model = require "moonpie.box_model"

  describe("setting up box model", function()
    it("initializes all the box values to zero", function()
      local box = box_model()
      assert.equals(0, box.x)
      assert.equals(0, box.y)
      assert.equals(0, box.content.width)
      assert.equals(0, box.content.height)
    end)
  end)

  describe("calculating the full box area", function()
    it("returns its content width and height", function()
      local box = box_model()
      box.content.width = 49
      box.content.height = 99
      assert.equals(49, box:width())
      assert.equals(99, box:height())
    end)

    it("includes margins in the total size", function()
      local box = box_model()
      box.margin.left = 3
      box.margin.right = 5
      box.margin.top = 5
      box.margin.bottom = 9
      box.content.width = 50
      box.content.height = 40
      assert.equals(58, box:width())
      assert.equals(54, box:height())
    end)
  end)

end)
