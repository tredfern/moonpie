-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Block", function()
  local mock_love = require "test_helpers.mock_love"
  local Block = require "moonpie.block"

  it("initializes based on the element it's referenced too", function()
    local text_element = { text = "Foo bar" }
    local b = Block(text_element)
    assert.equals(text_element, b.element)
  end)

  it("can have child nodes", function()
    local b = Block()
    local c1, c2 = {}, {}
    b:add(c1, c2)
    assert.equals(c1, b.children[1])
    assert.equals(c2, b.children[2])
  end)

  describe("Layout", function()
    local parent = Block({ width = 152, height = 499 })
    parent:layout()

    describe("initializing box model", function()
      it("has the margins of the element", function()
        local b = Block({ margin = 5 })
        local b2 = Block({ margin = { left = 9 } })
        assert.equals(5, b.box.margin.left)
        assert.equals(5, b.box.margin.top)
        assert.equals(5, b.box.margin.right)
        assert.equals(5, b.box.margin.bottom)
        assert.equals(9, b2.box.margin.left)
      end)

      it("tracks the parent layout used", function()
        local b = Block()
        b:layout(parent)
        assert.equals(parent.box, b.box.parent)
      end)
    end)

    describe("Width Calculations", function()
      it("uses it's parent width to determine it's maximum and defaults to full width", function()
        local b = Block()
        b:layout(parent)
        assert.equals(152, b.box.content.width)
      end)

      it("uses it's own width if provided on the node", function()
        local b = Block({ width = 120 })
        b:layout(parent)
        assert.equals(120, b.box.content.width)
      end)

      it("uses the width of its children if display is 'inline'", function()
        local b = Block({ display = "inline" })
        local c1 = Block({ width = 30 })
        local c2 = Block({ width = 34 })
        b:add(c1, c2)

        b:layout(parent)
        assert.equals(64, b.box.content.width)
      end)

      it("shaves off the margin from the width", function()
        local b = Block({ margin = 12 })
        b:layout(parent)
        assert.equals(128, b.box.content.width)
      end)

      it("shaves off the padding from the content width", function()
        local b = Block({ padding = 6 })
        b:layout(parent)
        assert.equals(140, b.box.content.width)
      end)

      it("shaves off the border from the content width", function()
        local b = Block({ border = 2 })
        b:layout(parent)
        assert.equals(148, b.box.content.width)
      end)
    end)

    it("uses its height if provided on the node", function()
      local b = Block({ height = 493 })
      b:layout(parent)
      assert.equals(493, b.box.content.height)
    end)

    it("updates the layouts of its children with itself as parent", function()
      local b = Block({ width = 39, height = 39 })
      local params
      local c1 = Block()
      c1.layout = function(s, p) params = { s, p } end
      b:add(c1)
      b:layout(parent)
      assert.equals(c1, params[1])
      assert.equals(b, params[2])
    end)

    describe("Horizontal layout", function()
      it("assigns the position of elements after calculating the width of them", function()
        local b = Block()
        local c1 = Block({width = 10 })
        local c2 = Block({width = 20 })
        local c3 = Block({width = 49 })
        b:add(c1, c2, c3)
        b:layout(parent)
        assert.equals(0, c1.box.x)
        assert.equals(0, c1.box.y)
        assert.equals(10, c2.box.x)
        assert.equals(0, c2.box.y)
        assert.equals(30, c3.box.x)
        assert.equals(0, c3.box.y)
      end)

      describe("Wrapping", function()
        local block = Block()
        local big_child = Block({ width = 500, height = 39})
        local little_child = Block({ width = 43, height = 32})
        block:add(big_child, little_child)
        block:layout(parent)

        it("puts a block onto another line if the next block cannot fit onto the line", function()
          assert.equals(0, big_child.box.x)
          assert.equals(0, big_child.box.y)
          assert.equals(0, little_child.box.x)
          assert.equals(39, little_child.box.y)
        end)

        it("calculates it's own height to be the size of all the lines", function()
          assert.equals(71, block.box.content.height)
        end)
      end)

      describe("Margins", function()
        local block = Block({ display = "inline", margin = 5 })
        local child = Block({ margin = 2, width = 10, height = 10 })
        block:add(child)
        block:layout(parent)

        it("starts the content based on the margin", function()
          local x, y = block.box:content_position()
          assert.equals(5, x)
          assert.equals(5, y)
        end)

        it("content area includes the margins of the child", function()
          assert.equals(14, block.box.content.width)
          assert.equals(14, block.box.content.height)
        end)

        it("uses the margins for the total size", function()
          assert.equals(14, child.box:height())
          assert.equals(14, child.box:width())
          assert.equals(24, block.box:height())
          assert.equals(24, block.box:width())
        end)
      end)
    end)
  end)

  describe("Status Checks", function()
    local b = Block({ width = 20, height = 30 })
    b:layout()

    it("can flag that the mouse is hovering", function()
      mock_love.mock(love.mouse, "getPosition", function() return 3, 5 end)
      assert.is_true(b:hover())
    end)

    it("returns false for hover if mouse is outside the region", function()
      mock_love.mock(love.mouse, "getPosition", function() return 300, 500 end)
      assert.is_false(b:hover())
    end)
  end)

  describe("Painting", function()
    it("translates its position to the x, y position", function()
      local b = Block()
      b.box.x = 39
      b.box.y = 59
      mock_love.mock(love.graphics, "push", spy.new(function() end))
      mock_love.mock(love.graphics, "translate", spy.new(function() end))
      mock_love.mock(love.graphics, "pop", spy.new(function() end))

      b:paint()
      assert.spy(love.graphics.push).was.called()
      assert.spy(love.graphics.translate).was.called_with(39, 59)
      assert.spy(love.graphics.pop).was.called()
    end)

    it("paints each of its children", function()
      local b = Block()
      local spy_paint = spy.new(function() end)
      local c1 = { paint = spy_paint }
      local c2 = { paint = spy_paint }

      b:add(c1, c2)
      b:paint()
      assert.spy(spy_paint).was.called_with(c1)
      assert.spy(spy_paint).was.called_with(c2)
    end)

    it("translates to where the background is to draw the background", function()
      mock_love.mock(love.graphics, "push", spy.new(function() end))
      mock_love.mock(love.graphics, "pop", spy.new(function() end))
      mock_love.mock(love.graphics, "translate", spy.new(function() end))
      local b = Block{ margin = 5, padding = 4, background_color = {1, 1, 1, 1 } }
      b:draw_background(b.element)
      assert.spy(love.graphics.push).was.called()
      assert.spy(love.graphics.translate).was.called.with(5, 5)
      assert.spy(love.graphics.pop).was.called()
    end)

    it("translates the children to where the content starts", function()
      mock_love.mock(love.graphics, "translate", spy.new(function() end))
      local b = Block({ margin = 5, padding = 4 })
      b:paint()
      assert.spy(love.graphics.translate).was.called.with(9, 9)
    end)

    it("paints a background.color for it's area if provided", function()
      mock_love.mock(love.graphics, "setColor", spy.new(function() end))
      mock_love.mock(love.graphics, "rectangle", spy.new(function() end))

      local node = { padding = 4, background_color = { 1, 1, 1, 1 }, width = 120, height = 483 }
      local b = Block(node)
      b:layout()

      b:paint()
      --check the background was called

      assert.spy(love.graphics.setColor).was.called_with(node.background_color)
      assert.spy(love.graphics.rectangle).was.called_with("fill", 0, 0, 128, 491)
    end)

    describe("border", function()
      local bordered = Block{ margin = 2, border = 3, width = 20, height = 25, border_color = { 1, 0, 1, 1 }  }
      bordered:layout()

      it("sets the line width to the border size", function()
        mock_love.mock(love.graphics, "setLineWidth", spy.new(function() end))
        bordered:paint()
        assert.spy(love.graphics.setLineWidth).was.called.with(3)
      end)

      it("sets the border color", function()
        mock_love.mock(love.graphics, "setColor", spy.new(function() end))
        bordered:paint()
        assert.spy(love.graphics.setColor).was.called.with(bordered.element.border_color)
      end)

      it("translates away the margin", function()
        mock_love.mock(love.graphics, "translate", spy.new(function() end))
        bordered:paint()
        assert.spy(love.graphics.translate).was.called.with(2, 2)
      end)

      it("draws a rectangle for the border", function()
        mock_love.mock(love.graphics, "rectangle", spy.new(function() end))
        bordered:paint()
        assert.spy(love.graphics.rectangle).was.called.with("line", 0, 0, bordered.box:border_size())
      end)
    end)

    describe("Hover State", function()
      local Element = require "moonpie.element"

      it("uses the hover state of the element for painting properties", function()
        mock_love.mock(love.mouse, "getPosition", function() return 24, 42 end)
        mock_love.mock(love.graphics, "setColor", spy.new(function() end))

        local element = Element("hover-test",
          {width = 120, height = 120, background_color = { 0, 0, 0, 0 } })
          :on_hover({ background = { color = { 1, 1, 1, 1 } } })
        local b = Block(element)
        b:layout()
        b:paint()

        assert.spy(love.graphics.setColor).was.called_with(element.hover.background_color)
      end)
    end)
  end)
end)
