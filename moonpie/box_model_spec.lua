-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Box Model", function()
  local box_model = require "moonpie.box_model"

  describe("setting up box model", function()
    it("initializes all the box values to zero", function()
      local box = box_model()
      assert.equals(0, box.area:left())
      assert.equals(0, box.area:right())
      assert.equals(0, box.area:top())
      assert.equals(0, box.area:bottom())
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

      assert.equals(0, box.content.width)
      assert.equals(0, box.content.height)
    end)
  end)

  describe("Calculating Box Model from pure control properties", function()
    it("sets everything to zero if no values provided", function()
      local ctrl = { }
      local box = box_model(ctrl)
      assert.equals(0, box.area:left())
      assert.equals(0, box.area:right())
      assert.equals(0, box.area:top())
      assert.equals(0, box.area:bottom())
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

      assert.equals(0, box.content.width)
      assert.equals(0, box.content.height)
    end)

    it("uses the content_size if no width/height set", function()
      local ctrl = { content_size = function() return 100, 50 end }
      local box = box_model(ctrl)
      assert.equals(0, box.area:left())
      assert.equals(100, box.area:right())
      assert.equals(0, box.area:top())
      assert.equals(50, box.area:bottom())

      assert.equals(100, box.content.width)
      assert.equals(50, box.content.height)
    end)

    it("uses the width - height if provided", function()
      local ctrl = { width = 39, height = 48 }
      local box = box_model(ctrl)
      assert.equals(39, box.content.width)
      assert.equals(48, box.content.height)
    end)
  end)
end)
