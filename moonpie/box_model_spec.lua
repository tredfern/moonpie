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
      assert.equals(0, box.margin.left)
      assert.equals(0, box.margin.top)
      assert.equals(0, box.margin.right)
      assert.equals(0, box.margin.bottom)
      assert.equals(0, box.padding.left)
      assert.equals(0, box.padding.right)
      assert.equals(0, box.padding.top)
      assert.equals(0, box.padding.bottom)
    end)

    it("sets all the margins to the same size if the element is set up as a number", function()
      local box = box_model{ margin = 5 }
      assert.equals(5, box.margin.left)
      assert.equals(5, box.margin.top)
      assert.equals(5, box.margin.bottom)
      assert.equals(5, box.margin.right)
    end)

    it("sets all the paddings to the same size if set as a number", function()
      local box = box_model{ padding = 12 }
      assert.equals(12, box.padding.left)
      assert.equals(12, box.padding.right)
      assert.equals(12, box.padding.top)
      assert.equals(12, box.padding.bottom)
    end)

    it("sets the parent if a second table is provided", function()
      local parent = box_model()
      local box = box_model({}, parent)
      assert.equals(parent, box.parent)
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

    it("uses the margins to figure out the left/top area of the content area", function()
      local box = box_model()
      box.margin.left = 42
      box.margin.top = 67
      local x, y = box:content_position()
      assert.equals(42, x)
      assert.equals(67, y)
    end)

    it("uses the padding to figure out the left/top are of the content area", function()
      local box = box_model{ padding = 3 }
      local x, y = box:content_position()
      assert.equals(3, x)
      assert.equals(3, y)
    end)

    it("uses the margins to calculate the start of the active area but not the padding", function()
      local box = box_model{ margin = 5, padding = 6 }
      local x, y = box:background_position()
      assert.equals(5, x)
      assert.equals(5, y)
    end)

    it("uses includes the padding when calculating the background size", function()
      local box = box_model{ margin = 2, padding = 7 }
      box.content.width = 4
      box.content.height = 3
      local w, h = box:background_size()
      assert.equals(18, w)
      assert.equals(17, h)
    end)

    describe("border", function()
      it("is included in total size", function()
        local box = box_model{ border = 3 }
        box.content.width = 10
        box.content.height = 12
        assert.equals(16, box:width())
        assert.equals(18, box:height())
      end)

      it("is included in background offset", function()
        local box = box_model{ border = 2 }
        local x, y = box:background_position()
        assert.equals(2, x)
        assert.equals(2, y)
      end)

      it("is included in the content offset", function()
        local box = box_model{ border = 2 }
        local x, y = box:content_position()
        assert.equals(2, x)
        assert.equals(2, y)
      end)

      it("identifies the top-left corner of the border", function()
        local box = box_model{ margin = 3, border = 2 }
        local x, y = box:border_position()
        assert.equals(3, x)
        assert.equals(3, y)
      end)

      it("can return the width and height for the border", function()
        local box = box_model{ border = 3 }
        box.content.width = 100
        box.content.height = 200
        local w, h = box:border_size()
        assert.equals(106, w)
        assert.equals(206, h)
      end)

      it("includes the padding in the width and height for the border", function()
        local box = box_model{ border = 1, padding = 2 }
        box.content.width = 100
        box.content.height = 100
        local w, h = box:border_size()
        assert.equals(106, w)
        assert.equals(106, h)
      end)
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

    it("includes padding in the total size", function()
      local box = box_model{ padding = { left = 1, right = 2, top = 3, bottom = 4 } }
      box.content.width = 30
      box.content.height = 22

      assert.equals(33, box:width())
      assert.equals(29, box:height())
    end)
  end)

  describe("it can return a region that represents the area contained by the box", function()
    it("calculates it's region based off its parent's region and its x + margin, y + margin", function()
      local parent = box_model({ margin = 2, border = 2, padding = 4 })
      parent.x = 50
      parent.y = 70
      local box = box_model({ margin = 5 }, parent)
      box.x = 10
      box.y = 20
      box.content.width = 60
      box.content.height = 70
      local region = box:region()
      assert.equals(73, region.left)
      assert.equals(103, region.top)
      assert.equals(133, region.right)
      assert.equals(173, region.bottom)
    end)
  end)
end)
