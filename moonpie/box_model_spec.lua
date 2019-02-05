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
  end)

  describe("Calculating Box Model from pure control properties", function()
    it("sets everything to zero if no values provided", function()
      local ctrl = { }
      local box = box_model(ctrl)
      assert.equals(0, box.content.width)
      assert.equals(0, box.content.height)
    end)

    it("uses the content_size if no width/height set", function()
      local ctrl = { content_size = function() return 100, 50 end }
      local box = box_model(ctrl)

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
