-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Box Model", function()
  local box_model = require "moonpie.box_model"
  describe("Calculating Box Model from pure control properties", function()
    it("has a size of just the content area with no border or margin", function()
      local ctrl = { content_size = function() return 100, 50 end }
      local box = box_model(ctrl)
      assert.equals(0, box.area:left())
      assert.equals(100, box.area:right())
      assert.equals(0, box.area:top())
      assert.equals(50, box.area:bottom())
      assert.equals(0, box.margin.left)
      assert.equals(0, box.margin.right)
      assert.equals(0, box.margin.top)
      assert.equals(0, box.margin.bottom)
      assert.equals(0, box.border.left)
      assert.equals(0, box.border.right)
      assert.equals(0, box.border.top)
      assert.equals(0, box.border.bottom)
      assert.equals(0, box.padding.left)
      assert.equals(0, box.padding.right)
      assert.equals(0, box.padding.top)
      assert.equals(0, box.padding.bottom)

      assert.equals(100, box.content.width)
      assert.equals(50, box.content.height)
      assert.equals(0, box.content.x)
      assert.equals(0, box.content.y)
    end)
  end)
end)
