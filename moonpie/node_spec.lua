-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Node", function()
  local mock_love = require "test_helpers.mock_love"
  local Node = require "moonpie.node"

  it("initializes based on the component it's referenced too", function()
    local text_component = { text = "Foo bar" }
    local b = Node(text_component)
    assert.equals(text_component, b.component)
  end)

  it("can be initialized with a parent node", function()
    local parent_node = Node({})
    local child_node = Node({}, parent_node)
    assert.equals(parent_node, child_node.parent)
  end)

  it("can have child nodes", function()
    local b = Node()
    local c1, c2 = {}, {}
    b:add(c1, c2)
    assert.equals(c1, b.children[1])
    assert.equals(c2, b.children[2])
  end)

  it("passes any functions it doesn't know to the component", function()
    local comp = { click = spy.new(function() end) }
    local b = Node(comp)
    b:click()
    assert.spy(comp.click).was.called.with(b)
  end)

  it("layout refresh is needed if the component has been modified", function()
    local comp = { text = "foobar",  }
    local b = Node(comp)
    comp.refresh_layout = true
    assert.is_true(b:refresh_needed())
  end)

  it("clears the refresh layout flag after calling layout", function()
    local comp = { refresh_layout = true, width = 10, height = 10 }
    local b = Node(comp)
    b:layout()
    assert.is_falsy(comp.refresh_layout)
  end)

  describe("Layout", function()
    local parent = Node({ width = 152, height = 499 })
    parent:layout()

    describe("initializing box model", function()
      it("has the margins of the component", function()
        local b = Node({ margin = 5 })
        local b2 = Node({ margin = { left = 9 } })
        assert.equals(5, b.box.margin.left)
        assert.equals(5, b.box.margin.top)
        assert.equals(5, b.box.margin.right)
        assert.equals(5, b.box.margin.bottom)
        assert.equals(9, b2.box.margin.left)
      end)

      it("tracks the parent layout used", function()
        local b = Node()
        b:layout(parent)
        assert.equals(parent.box, b.box.parent)
      end)
    end)

    describe("Width Calculations", function()
      it("uses it's parent width to determine it's maximum and defaults to full width", function()
        local b = Node()
        b:layout(parent)
        assert.equals(152, b.box.content.width)
      end)

      it("uses it's own width if provided on the node", function()
        local b = Node({ width = 120 })
        b:layout(parent)
        assert.equals(120, b.box.content.width)
      end)

      it("uses the width of its children if display is 'inline'", function()
        local b = Node({ display = "inline" })
        local c1 = Node({ width = 30 })
        local c2 = Node({ width = 34 })
        b:add(c1, c2)

        b:layout(parent)
        assert.equals(64, b.box.content.width)
      end)

      it("shaves off the margin from the width", function()
        local b = Node({ margin = 12 })
        b:layout(parent)
        assert.equals(128, b.box.content.width)
      end)

      it("shaves off the padding from the content width", function()
        local b = Node({ padding = 6 })
        b:layout(parent)
        assert.equals(140, b.box.content.width)
      end)

      it("shaves off the border from the content width", function()
        local b = Node({ border = 2 })
        b:layout(parent)
        assert.equals(148, b.box.content.width)
      end)
    end)

    it("uses its height if provided on the node", function()
      local b = Node({ height = 493 })
      b:layout(parent)
      assert.equals(493, b.box.content.height)
    end)

    it("updates the layouts of its children with itself as parent", function()
      local b = Node({ width = 39, height = 39 })
      local params
      local c1 = Node()
      c1.layout = function(s, p) params = { s, p } end
      b:add(c1)
      b:layout(parent)
      assert.equals(c1, params[1])
      assert.equals(b, params[2])
    end)

    it("keeps the same layout if called multiple times in a row", function()
      local b = Node({ width = 1, margin = 1, padding = 1, border = 1 })
      local c = Node({ width = 1, height = 1, margin = 1, padding = 1, border = 1 })
      b:add(c)
      b:layout()
      assert.equals(0, b.box.x)
      assert.equals(0, b.box.y)
      assert.equals(0, c.box.x)
      assert.equals(0, c.box.y)
      assert.equals(13, b.box:height())
      assert.equals(7, c.box:height())
      b:layout()
      assert.equals(0, b.box.x)
      assert.equals(0, b.box.y)
      assert.equals(0, c.box.x)
      assert.equals(0, c.box.y)
      assert.equals(13, b.box:height())
      assert.equals(7, c.box:height())
    end)

    describe("Horizontal layout", function()
      it("assigns the position of components after calculating the width of them", function()
        local b = Node()
        local c1 = Node({width = 10 })
        local c2 = Node({width = 20 })
        local c3 = Node({width = 49 })
        b:add(c1, c2, c3)
        b:layout(parent)
        assert.equals(0, c1.box.x)
        assert.equals(0, c1.box.y)
        assert.equals(10, c2.box.x)
        assert.equals(0, c2.box.y)
        assert.equals(30, c3.box.x)
        assert.equals(0, c3.box.y)
      end)

      describe("Child Alignment", function()
        local b = Node()
        local c1 = Node({ width = 10, align = "right" })
        b:add(c1)
        b:layout(parent)
        assert.equals(parent.width - 10, c1.box.x)
      end)

      describe("Wrapping", function()
        local node = Node()
        local big_child = Node({ width = 500, height = 39})
        local little_child = Node({ width = 43, height = 32})
        node:add(big_child, little_child)
        node:layout(parent)

        it("puts a node onto another line if the next node cannot fit onto the line", function()
          assert.equals(0, big_child.box.x)
          assert.equals(0, big_child.box.y)
          assert.equals(0, little_child.box.x)
          assert.equals(39, little_child.box.y)
        end)

        it("calculates it's own height to be the size of all the lines", function()
          assert.equals(71, node.box.content.height)
        end)
      end)

      describe("Margins", function()
        local node = Node({ display = "inline", margin = 5 })
        local child = Node({ margin = 2, width = 10, height = 10 })
        node:add(child)
        node:layout(parent)

        it("starts the content based on the margin", function()
          local x, y = node.box:content_position()
          assert.equals(5, x)
          assert.equals(5, y)
        end)

        it("content area includes the margins of the child", function()
          assert.equals(14, node.box.content.width)
          assert.equals(14, node.box.content.height)
        end)

        it("uses the margins for the total size", function()
          assert.equals(14, child.box:height())
          assert.equals(14, child.box:width())
          assert.equals(24, node.box:height())
          assert.equals(24, node.box:width())
        end)
      end)
    end)
  end)

  describe("Status Checks", function()
    local b = Node({ width = 20, height = 30 })
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
      local b = Node()
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
      local b = Node()
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
      local b = Node{ margin = 5, padding = 4, background_color = {1, 1, 1, 1 } }
      b:paint(b.component)
      assert.spy(love.graphics.push).was.called()
      assert.spy(love.graphics.translate).was.called.with(5, 5)
      assert.spy(love.graphics.pop).was.called()
    end)


    it("translates the children to where the content starts", function()
      mock_love.mock(love.graphics, "translate", spy.new(function() end))
      local b = Node({ margin = 5, padding = 4 })
      b:paint()
      assert.spy(love.graphics.translate).was.called.with(9, 9)
    end)

    describe("rectangle tests", function()
      mock_love.mock(love.graphics, "setColor", spy.new(function() end))
      mock_love.mock(love.graphics, "rectangle", spy.new(function() end))

      it("paints a background.color for it's area if provided", function()
        local node = { padding = 4, background_color = { 1, 1, 1, 1 }, width = 120, height = 483 }
        local b = Node(node)
        b:layout()
        b:paint()

        assert.spy(love.graphics.setColor).was.called_with(node.background_color)
        assert.spy(love.graphics.rectangle).was.called_with("fill", 0, 0, 128, 491, 0, 0)
      end)

      it("provides rounded corners if provided", function()
        local node = { background_color = {1, 1, 1, 1}, width = 120, height = 40,
          corner_radius_x = 2, corner_radius_y = 3 }
        local b = Node(node)
        b:layout()
        b:paint()
        assert.spy(love.graphics.rectangle).was.called.with("fill", 0, 0, 120, 40, 2, 3)
      end)
    end)

    it("can lookup the color if specified as a string", function()
      local colors = require "moonpie.colors"
      mock_love.mock(love.graphics, "setColor", spy.new(function() end))
      local comp = { background_color = "red", width = 120, height = 483 }
      local b = Node(comp)
      b:layout()
      b:paint()
      assert.spy(love.graphics.setColor).was.called.with(colors.red)
    end)

    describe("border", function()
      local bordered = Node{ margin = 2, border = 3, width = 20, height = 25, border_color = { 1, 0, 1, 1 }  }
      bordered:layout()

      it("sets the line width to the border size", function()
        mock_love.mock(love.graphics, "setLineWidth", spy.new(function() end))
        bordered:paint()
        assert.spy(love.graphics.setLineWidth).was.called.with(3)
      end)

      it("sets the border color", function()
        mock_love.mock(love.graphics, "setColor", spy.new(function() end))
        bordered:paint()
        assert.spy(love.graphics.setColor).was.called.with(bordered.component.border_color)
      end)

      it("translates away the margin", function()
        mock_love.mock(love.graphics, "translate", spy.new(function() end))
        bordered:paint()
        assert.spy(love.graphics.translate).was.called.with(2, 2)
      end)

      it("draws a rectangle for the border", function()
        mock_love.mock(love.graphics, "rectangle", spy.new(function() end))
        bordered:paint()
        local w, h = bordered.box:border_size()
        assert.spy(love.graphics.rectangle).was.called.with("line", 0, 0, w, h, 0, 0)
      end)

      it("can lookup the color if specified as a string", function()
        local colors = require "moonpie.colors"
        mock_love.mock(love.graphics, "setColor", spy.new(function() end))
        local comp = { border_color = "red", border = 2, width = 120, height = 483 }
        local b = Node(comp)
        b:layout()
        b:paint()
        assert.spy(love.graphics.setColor).was.called.with(colors.red)
      end)

      it("provides rounded corners if provided", function()
        mock_love.mock(love.graphics, "rectangle", spy.new(function() end))
        local node = { border = 1, border_color = {1, 1, 1, 1}, width = 120, height = 40,
          corner_radius_x = 2, corner_radius_y = 3 }
        local b = Node(node)
        b:layout()
        b:paint()
        assert.spy(love.graphics.rectangle).was.called.with("line", 0, 0, 122, 42, 2, 3)
      end)
    end)

    describe("Hover State", function()
      local Component = require "moonpie.components"

      it("uses the hover state of the component for painting properties", function()
        mock_love.mock(love.mouse, "getPosition", function() return 24, 42 end)
        mock_love.mock(love.graphics, "setColor", spy.new(function() end))

        local component = Component("hover-test",
          {width = 120, height = 120, background_color = { 0, 0, 0, 0 } })
          :on_hover({ background = { color = { 1, 1, 1, 1 } } })
        local b = Node(component)
        b:layout()
        b:paint()

        assert.spy(love.graphics.setColor).was.called_with(component.hover.background_color)
      end)
    end)
  end)
end)
