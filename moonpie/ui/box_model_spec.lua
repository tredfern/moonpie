-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Box Model", function()
  local BoxModel = require "moonpie.ui.box_model"

  describe("setting up box model", function()
    it("initializes all the box values to zero", function()
      local box = BoxModel()
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
      local box = BoxModel{ margin = 5 }
      assert.equals(5, box.margin.left)
      assert.equals(5, box.margin.top)
      assert.equals(5, box.margin.bottom)
      assert.equals(5, box.margin.right)
    end)

    it("sets all the paddings to the same size if set as a number", function()
      local box = BoxModel{ padding = 12 }
      assert.equals(12, box.padding.left)
      assert.equals(12, box.padding.right)
      assert.equals(12, box.padding.top)
      assert.equals(12, box.padding.bottom)
    end)

    it("sets the parent if a second table is provided", function()
      local parent = BoxModel()
      local box = BoxModel({}, parent)
      assert.equals(parent, box.parent)
    end)
  end)

  describe("calculating the full box area", function()
    it("returns its content width and height", function()
      local box = BoxModel()
      box:setContentSize(49, 99)
      assert.equals(49, box.width)
      assert.equals(99, box.height)
    end)

    it("uses the margins to figure out the left/top area of the content area", function()
      local box = BoxModel({ margin = { left = 42, top = 67} })
      assert.equals(42, box.contentPosition.x)
      assert.equals(67, box.contentPosition.y)
    end)

    it("uses the padding to figure out the left/top are of the content area", function()
      local box = BoxModel{ padding = 3 }
      assert.equals(3, box.contentPosition.x)
      assert.equals(3, box.contentPosition.y)
    end)

    it("uses the margins to calculate the start of the active area but not the padding", function()
      local box = BoxModel{ margin = 5, padding = 6 }
      assert.equals(5, box.backgroundPosition.x)
      assert.equals(5, box.backgroundPosition.y)
    end)

    it("uses includes the padding when calculating the background size", function()
      local box = BoxModel{ margin = 2, padding = 7 }
      box:setContentSize(4, 3)
      assert.equals(18, box.backgroundPosition.width)
      assert.equals(17, box.backgroundPosition.height)
    end)

    describe("border", function()
      it("is included in total size", function()
        local box = BoxModel{ border = 3 }
        box:setContentSize(10, 12)
        assert.equals(16, box.width)
        assert.equals(18, box.height)
      end)

      it("is included in background offset", function()
        local box = BoxModel{ border = 2 }
        assert.equals(2, box.backgroundPosition.x)
        assert.equals(2, box.backgroundPosition.y)
      end)

      it("is included in the content offset", function()
        local box = BoxModel{ border = 2 }
        assert.equals(2, box.contentPosition.x)
        assert.equals(2, box.contentPosition.y)
      end)

      it("identifies the top-left corner of the border", function()
        local box = BoxModel{ margin = 3, border = 2 }
        assert.equals(3, box.borderPosition.x)
        assert.equals(3, box.borderPosition.y)
      end)

      it("can return the width and height for the border", function()
        local box = BoxModel{ border = 3 }
        box:setContentSize(100, 200)
        assert.equals(106, box.borderPosition.width)
        assert.equals(206, box.borderPosition.height)
      end)

      it("includes the padding in the width and height for the border", function()
        local box = BoxModel{ border = 1, padding = 2 }
        box:setContentSize(100, 100)
        assert.equals(106, box.borderPosition.width)
        assert.equals(106, box.borderPosition.height)
      end)
    end)


    it("includes margins in the total size", function()
      local box = BoxModel({
        margin = { left = 3, right = 5, top = 5, bottom = 9 }
      })
      box:setContentSize(50, 40)
      assert.equals(58, box.width)
      assert.equals(54, box.height)
    end)

    it("includes padding in the total size", function()
      local box = BoxModel{ padding = { left = 1, right = 2, top = 3, bottom = 4 } }
      box:setContentSize(30, 22)

      assert.equals(33, box.width)
      assert.equals(29, box.height)
    end)
  end)

  describe("it can return a region that represents the area contained by the box", function()
    it("calculates it's region based off its parent's region and its x + margin, y + margin", function()
      local parent = BoxModel({ margin = 2, border = 2, padding = 4 })
      parent:setPosition(50, 70)
      local box = BoxModel({ margin = 5 }, parent)
      box:setPosition(10, 20)
      box:setContentSize(60, 70)
      local region = box:region()
      assert.equals(73, region.left)
      assert.equals(103, region.top)
      assert.equals(133, region.right)
      assert.equals(173, region.bottom)
    end)

    it("complex hierarchy", function()
      local parent = BoxModel({ margin = 5, border = 2, padding = 3 })
      parent:setPosition(0, 0)
      local box = BoxModel({ margin = 5 }, parent)
      box:setPosition(0, 0)
      local child = BoxModel({ margin = 5 }, box)
      child:setPosition(0, 0)
      local region = child:region()
      assert.equals(20, region.left)
      assert.equals(20, region.top)
    end)
  end)
end)
