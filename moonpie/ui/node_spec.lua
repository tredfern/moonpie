-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Node", function()
  local mock_love = require "moonpie.test_helpers.mock_love"
  local Node = require "moonpie.ui.node"
  local styles = require "moonpie.ui.styles"

  it("can be initialized with a parent node", function()
    local p = Node({})
    local c = Node({}, p)
    assert.equals(p, c.parent)
    assert.equals(p.box, c.box.parent)
  end)

  it("can have child nodes", function()
    local b = Node()
    local c1, c2 = {}, {}
    b:add(c1, c2)
    assert.equals(c1, b.children[1])
    assert.equals(c2, b.children[2])
  end)

  it("can remove children", function()
    local b = Node()
    local c1, c2 = {}, {}
    b:add(c1, c2)
    b:clear_children()
    assert.equals(0, #b.children)
  end)

  it("calls destroy on all children when cleared", function()
    local b = Node()
    local c1, c2 = Node(), Node()
    spy.on(c1, "destroy")
    spy.on(c2, "destroy")
    b:add(c1, c2)
    b:clear_children()
    assert.spy(c1.destroy).was.called()
    assert.spy(c2.destroy).was.called()
  end)

  it("looks like the component plus any styles", function()
    styles.add("test1", { padding = 10 })
    local c = { style = "test1", width = 100, click = spy.new(function() end) }
    local n = Node(c)
    assert.equals(10, n.padding)
    assert.equals(100, n.width)
    n:click()
    assert.spy(c.click).was.called.with(n)
  end)

  it("passes the hover flag to the computed styles", function()
    styles.add("text", { color = "green", _hover_ = { color = "red" } })
    local c = { style = "text" }
    local n = Node(c)
    n.hover = function() return true end -- just override the hover check
    n:refresh_style()
    assert.equals("red", n.color)
  end)

  it("assigns itself to the component", function()
    local c = { }
    local n = Node(c)
    assert.equals(n, c.node)
  end)

  describe("Initializing the box", function()
    it("uses styles for box definition", function()
      styles.add("box_test", { padding = 10, margin = 20, width = 100 })
      local b = Node({ style = "box_test" })
      assert.equals(20, b.box.margin.left)
      assert.equals(20, b.box.margin.top)
      assert.equals(20, b.box.margin.bottom)
      assert.equals(20, b.box.margin.right)
      assert.equals(10, b.box.padding.right)
      assert.equals(10, b.box.padding.left)
      assert.equals(10, b.box.padding.bottom)
      assert.equals(10, b.box.padding.top)
      assert.equals(100, b.width)
    end)

    it("has the margins of the component", function()
      local b = Node({ margin = 5 })
      local b2 = Node({ margin = { left = 9 } })
      assert.equals(5, b.box.margin.left)
      assert.equals(5, b.box.margin.top)
      assert.equals(5, b.box.margin.right)
      assert.equals(5, b.box.margin.bottom)
      assert.equals(9, b2.box.margin.left)
    end)
  end)


  describe("Layout", function()
    it("uses the layout defined in the component if available", function()
      local c = { layout = spy.new(function() end) }
      local n = Node(c)
      n:layout("values")
      assert.spy(c.layout).was.called.with(n, "values")
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
    it("uses the components paint method if provided", function()
      local c = { paint = function() end }
      local n = Node(c)
      assert.equals(c.paint, n.paint)
    end)
  end)

  describe("destroy", function()
    it("sets the component and parent to nil", function()
      local p = Node({})
      local c = {}
      local n = Node(c, p)
      n:destroy()
      assert.is_nil(n.c)
      assert.is_nil(n.p)
      assert.is_nil(c.node)
    end)

    it("calls destroy on it's children", function()
      local p = Node({})
      local c = Node({}, p)
      p:add(c)
      p:destroy()
      assert.is_nil(c.parent)
    end)

    it("calls unmount on component if defined", function()
      local unmount = spy.new(function() end)
      local c = Node({ unmounted = unmount })
      c:destroy()
      assert.spy(unmount).was.called()
    end)
  end)
end)
