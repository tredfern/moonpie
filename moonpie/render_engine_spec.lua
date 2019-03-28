-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("RenderEngine", function()
  local RenderEngine = require "moonpie.render_engine"
  local Component = require "moonpie.components.component"
  local Mouse = require "moonpie.mouse"

  before_each(function()
    Component("complex", function(props)
      return {
        text = "complex",
        value = props.value,
        render = function(self)
          return { text = "foo", value = self.value }
        end
      }
    end)
  end)

  it("asserts that the specified layer is one that it supports", function()
    assert.has_no.errors(function() RenderEngine("ui", {}) end)
    assert.has.errors(function() RenderEngine("debuuu", {}) end)
  end)

  describe("Building the tree", function()
    describe("adding children", function()
      it("sets all the components on the root to children of it", function()
        local ele1, ele2, ele3 = { }, { }, { }
        local r = RenderEngine("ui", ele1, ele2, ele3)
        assert.equals(3, #r.root.children)
      end)

      it("assigns the parent", function()
        local c = { }
        local p = { c }
        local r = RenderEngine("ui", p)
        assert.equals(r.root, r.root.children[1].parent)
        assert.equals(r.root.children[1], r.root.children[1].children[1].parent)
      end)
    end)

    it("can build a deep tree", function()
      local r = RenderEngine("ui",
      { id = "1",
        { id = "1.1",
          { id = "1.1.1" },
          { id = "1.1.2" }
        }
      },
      {
        id = "2"
      })
      assert.equals("1", r.root.children[1].id)
      assert.equals("2", r.root.children[2].id)
      assert.equals("1.1", r.root.children[1].children[1].id)
      assert.equals("1.1.1", r.root.children[1].children[1].children[1].id)
      assert.equals("1.1.2", r.root.children[1].children[1].children[2].id)
    end)
  end)

  describe("Searching", function()
    it("can find a node by a component", function()
      local c = Component.complex()
      local r = RenderEngine("ui", c)
      local node = r:find_by_component(c)
      assert.equals(c, node.component)
    end)
  end)

  describe("Paint", function()
    it("paints all the layers", function()
      local ui = RenderEngine("ui", Component.complex())
      local debug = RenderEngine("debug", Component.complex())
      local floating = RenderEngine("floating", Component.complex())
      ui.root.paint = spy.new(function() end)
      debug.root.paint = spy.new(function() end)
      floating.root.paint = spy.new(function() end)

      RenderEngine.paint()
      assert.spy(ui.root.paint).was.called.with(ui.root)
      assert.spy(floating.root.paint).was.called.with(floating.root)
      assert.spy(debug.root.paint).was.called.with(debug.root)
    end)

    it("delegates to root", function()
      local r = RenderEngine("ui", {})
      r.root.paint = spy.new(function() end)
      r:paint()
      assert.spy(r.root.paint).was.called()
    end)

    it("refreshes the style information before painting", function()
      local c = Component.complex()
      local r = RenderEngine("ui", c)
      local n = r:find_by_component(c)
      n.refresh_style = spy.new(function() end)
      r:paint(Mouse)
      assert.spy(n.refresh_style).was.called.with(n)
    end)
  end)

  describe("Complex Components", function()
    before_each(function()
    end)

    it("calls the render method and adds results to children if component has a render method", function()
      local c = Component.complex()
      local r = RenderEngine("ui", c)

      -- nodes should be Root -> Complex (c) -> text = "foo"
      assert.equals("complex", r.root.children[1].text)
      assert.equals("foo", r.root.children[1].children[1].text)
    end)
  end)

  describe("Rendering to multiple layers", function()
    it("when a component specifies a target layer, append to root of that one", function()
      local float = { target_layer = "floating" }
      local multi = { float }
      RenderEngine("ui", multi)
      assert.is_nil(RenderEngine.layers.ui:find_by_component(float))
      local n = RenderEngine.layers.floating:find_by_component(float)
      assert.not_nil(n)
      assert.equals(float, n.component)
      assert.equals(RenderEngine.layers.floating.root, n.parent)
    end)

    it("updates the layout of the root layer after adding a new node", function()
      local float = { target_layer = "floating" }
      local multi = { float }
      local old = RenderEngine.layers.floating.root.layout
      RenderEngine.layers.floating.root.layout = spy.new(function(...) return old(...) end)
      RenderEngine("ui", multi)
      assert.spy(RenderEngine.layers.floating.root.layout).was.called()
    end)
  end)

  describe("Updating", function()
    it("updates all the layers", function()
      local ui = RenderEngine("ui", {})
      local debug = RenderEngine("debug", {})
      local modal = RenderEngine("modal", {})
      local mouse = { update = spy.new(function() end) }

      RenderEngine.update(mouse)
      assert.spy(mouse.update).was.called.with(mouse, ui.root)
      assert.spy(mouse.update).was.called.with(mouse, debug.root)
      assert.spy(mouse.update).was.called.with(mouse, modal.root)
    end)

    describe("Refreshing", function()
      it("will rerender child output if the component is flagged for updates and has a render method", function()
        local c = Component.complex()
        local r = RenderEngine("ui", c)
        c:update({ value = 10 })
        r:update(Mouse)
        assert.equals(10, r.root.children[1].children[1].value)
        assert.is_false(c:has_updates())
      end)

      it("updates the layout of the newly rendered children", function()
        local c = Component.complex()
        local r = RenderEngine("ui", c)
        local n = r:find_by_component(c)
        n.layout = spy.new(function() end)
        c:update({ value = 10 })
        r:update(Mouse)
        assert.spy(n.layout).was.called()
      end)

      it("will not render components that are hidden", function()
        local c = Component.complex()
        local r = RenderEngine("ui", c)
        c.render = spy.new(function() return {} end)
        c:update({ value = 10 })
        c:hide()
        r:update(Mouse)
        assert.not_nil(c.render)
        assert.spy(c.render).was_not.called()
      end)
    end)

    describe("Handling Mouse Behavior", function()
      it("updates the mouse passing in it's root node", function()
        local r = RenderEngine("ui", {})
        local mouse = { update = spy.new(function() end) }
        r:update(mouse)
        assert.spy(mouse.update).was.called.with(mouse, r.root)
      end)
    end)
  end)

  describe("layers", function()
    it("has a table to hold all the layers", function()
      assert.not_nil(RenderEngine.layers)
    end)

    it("by default all rendering is going to the UI layer", function()
      local c = Component.complex()
      local rend = RenderEngine("ui", c)
      assert.equals(rend, RenderEngine.layers.ui)
    end)

    it("can render to a specific layer", function()
      local c = Component.complex()
      local rend = RenderEngine("debug", c)
      assert.equals(rend, RenderEngine.layers.debug)
    end)

    it("orders the layers ui, modal, floating, debug", function()
      local ui = RenderEngine("ui", {})
      local debug = RenderEngine("debug", {})
      local floating = RenderEngine("floating", {})
      local modal = RenderEngine("modal", {})

      assert.same({ ui, modal, floating, debug }, RenderEngine.ordered_layers())
    end)
  end)
end)
