-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("RenderEngine", function()
  local RenderEngine = require "moonpie.ui.render_engine"
  local Component = require "moonpie.ui.components.component"
  local Mouse = require "moonpie.mouse"

  before_each(function()
    RenderEngine.clearAll()
    Component("complex", function(props)
      return {
        id = "top",
        text = "complex",
        value = props.value,
        render = function(self)
          return { id = "child_text", text = "foo", value = self.value }
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
      it("calls mounted on a component if configured", function()
        local param
        local c = {
          mounted = spy.new(function(self) param = self end),
          id = 12345
        }
        RenderEngine("ui", { c })

        assert.spy(c.mounted).was.called()
        assert.equals(param.id, c.id)
        assert.not_nil(param.box) -- Validating we are actually getting the node
      end)

      it("sets all the components on the root to children of it", function()
        local ele1, ele2, ele3 = { }, { }, { }
        local r = RenderEngine("ui", ele1, ele2, ele3)
        assert.equals(3, #r.children)
      end)

      it("assigns the parent", function()
        local c = { }
        local p = { c }
        local r = RenderEngine("ui", p)
        assert.equals(r, r.children[1].parent)
        assert.equals(r.children[1], r.children[1].children[1].parent)
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
      assert.equals("1", r.children[1].id)
      assert.equals("2", r.children[2].id)
      assert.equals("1.1", r.children[1].children[1].id)
      assert.equals("1.1.1", r.children[1].children[1].children[1].id)
      assert.equals("1.1.2", r.children[1].children[1].children[2].id)
    end)
  end)

  describe("Searching", function()
    it("can find a node by a component", function()
      local c = Component.complex()
      RenderEngine("ui", c)
      local node = RenderEngine.findByComponent(c)
      assert.equals(c, node.component)
    end)

    it("can search all the layers to find a node by component", function()
      local c = Component.complex()
      RenderEngine("ui", c)
      local node = RenderEngine.findByComponent(c)
      assert.equals(c, node.component)
    end)

    it("can find a component by it's id", function()
      local c = Component.complex()
      assert.equals("top", c.id)
      RenderEngine("ui", c)
      assert.equals(c, RenderEngine.findByID("top").component)
      assert.not_nil(RenderEngine.findByID("child_text"))
    end)

    it("logs an error and finds nothing if findByID is passed nil", function()
      RenderEngine("ui", {})
      assert.is_nil(RenderEngine.findByID(nil))
    end)

    it("can find a component by it's position", function()
      local c1 = { width = 100, height = 50 }
      local c2 = { width = 50, height = 25 }

      RenderEngine("ui", {
        c1,
        c2
      })

      local n = RenderEngine.findByComponent(c1)
      local n2 = RenderEngine.findByComponent(c2)
      assert.array_includes(n, RenderEngine.findByPosition(38, 22))
      assert.array_includes(n2, RenderEngine.findByPosition(38, 65))
    end)
  end)

  describe("Paint", function()
    it("paints all the layers", function()
      local ui = RenderEngine("ui", Component.complex())
      local debug = RenderEngine("debug", Component.complex())
      local floating = RenderEngine("floating", Component.complex())
      ui.paint = spy.new(function() end)
      debug.paint = spy.new(function() end)
      floating.paint = spy.new(function() end)

      RenderEngine.paint()
      assert.spy(ui.paint).was.called.with(ui)
      assert.spy(floating.paint).was.called.with(floating)
      assert.spy(debug.paint).was.called.with(debug)
    end)

    it("refreshes the style information before painting", function()
      local c = Component.complex()
      RenderEngine("ui", c)
      local n = RenderEngine.findByComponent(c)
      n.refreshStyle = spy.new(function() end)
      RenderEngine.paint(Mouse)
      assert.spy(n.refreshStyle).was.called()
    end)
  end)

  describe("Complex Components", function()
    before_each(function()
    end)

    it("calls the render method and adds results to children if component has a render method", function()
      local c = Component.complex()
      local r = RenderEngine("ui", c)

      -- nodes should be Root -> Complex (c) -> text = "foo"
      assert.equals("complex", r.children[1].text)
      assert.equals("foo", r.children[1].children[1].text)
    end)
  end)

  describe("Rendering to multiple layers", function()
    it("when a component specifies a target layer, append to root of that one", function()
      local float = { targetLayer = "floating" }
      local multi = { float }
      RenderEngine("ui", multi)
      local n = RenderEngine.findByComponent(float)
      assert.equals(RenderEngine.layers.floating, n.parent)
    end)

    it("updates the layout of the root layer after adding a new node", function()
      local float = { targetLayer = "floating" }
      local multi = { float }
      local old = RenderEngine.layers.floating.layout
      RenderEngine.layers.floating.layout = spy.new(function(...) return old(...) end)
      RenderEngine("ui", multi)
      assert.spy(RenderEngine.layers.floating.layout).was.called()
    end)

    it("makes sure to assign the box parent to the layer root", function()
      local float = { targetLayer = "floating" }
      local multi = { float }
      RenderEngine("ui", multi)
      local n = RenderEngine.findByComponent(float)
      assert.equals(RenderEngine.layers.floating.box, n.box.parent)
    end)
  end)

  describe("Updating", function()
    describe("Refreshing", function()
      it("will rerender child output if the component is flagged for updates and has a render method", function()
        local c = Component.complex()
        local r = RenderEngine("ui", { c })
        c:update({ value = 13 })
        assert.is_true(c:hasUpdates())
        RenderEngine.update(Mouse)
        assert.equals(13, r.children[1].children[1].value)
        assert.is_false(c:hasUpdates())
      end)

      it("updates the layout of the newly rendered children", function()
        local c = Component.complex()
        RenderEngine("ui", c)
        local n = RenderEngine.findByComponent(c)
        n.layout = spy.new(function() end)
        c:update({ value = 10 })
        RenderEngine.update(Mouse)
        assert.spy(n.layout).was.called()
      end)

      it("will not render components that are hidden", function()
        local c = Component.complex()
        RenderEngine("ui", c)
        c.render = spy.new(function() return {} end)
        c:update({ value = 10 })
        c:hide()
        RenderEngine.update(Mouse)
        assert.not_nil(c.render)
        assert.spy(c.render).was_not.called()
      end)

      it("will just update the layout if no render method", function()
        Component("simple", function() return {} end)
        local c = Component.simple()
        RenderEngine("ui", c)
        c.layout = spy.new(function() end)
        c:update({ foo = "bar" })
        RenderEngine.update(Mouse)
        assert.spy(c.layout).was.called()
      end)

      it("calls layout on the layer to account for any changes", function()
        Component("simple", function() return {} end)
        local c = Component.simple()
        RenderEngine("ui", c)
        spy.on(RenderEngine.layers.ui, "layout")
        c:update({ foo = "bar" })
        RenderEngine.update(Mouse)
        assert.spy(RenderEngine.layers.ui.layout).was.called()
      end)

      it("will remove a component flagged for removal", function()
        Component("remove", function() return {} end)
        local c = Component.remove()
        RenderEngine("ui", c)
        c:flagRemoval()
        assert.is_true(c:needsRemoval())
        RenderEngine.update(Mouse)
        assert.is_nil(RenderEngine.findByComponent(c))
      end)

      it("can handle a component being updated that isn't in the node tree", function()
        Component("simple", function() return {} end)
        local c = Component.simple()
        c:update { text = "foo" }
        assert.has_no_errors(function() RenderEngine.update(Mouse) end)
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

    it("orders the layers background, ui, modal, floating, debug", function()
      local background = RenderEngine("background", {})
      local ui = RenderEngine("ui", {})
      local debug = RenderEngine("debug", {})
      local floating = RenderEngine("floating", {})
      local modal = RenderEngine("modal", {})
      local unit_test = RenderEngine("unit_test", {})

      assert.same({ background, ui, modal, floating, debug, unit_test }, RenderEngine.orderedLayers())
    end)
  end)

  it("can reset the engine to clear everything out", function()
    RenderEngine("ui", {})
    RenderEngine.clearAll()
    assert.equals(0, #RenderEngine.layers.ui.children)
    assert.equals(0, #RenderEngine.layers.floating.children)
    assert.equals(0, #RenderEngine.layers.debug.children)
    assert.equals(0, #RenderEngine.layers.modal.children)
  end)

  it("will remove an existing component instance/node from hierarchy if added again", function()
    local f = { targetLayer = "floating" }
    local c = { f }
    RenderEngine("ui", c)
    local n = RenderEngine.findByComponent(f)
    RenderEngine("ui", c)
    local n2 = RenderEngine.findByComponent(f)

    assert.not_equals(n, n2)
    assert.equals(1, #RenderEngine.layers.floating.children)
    assert.equals(n2, RenderEngine.layers.floating.children[1])
  end)

  it("properly collects garbage when node is removed is called", function()
    local unmount = spy.new(function() end)
    Component("collect", function() return { unmounted = unmount } end)
    local c = Component.collect()
    RenderEngine("ui", c)
    c:flagRemoval()
    assert.not_nil(c.node)
    RenderEngine.update(Mouse)
    collectgarbage()
    assert.spy(unmount).was.called()
  end)
end)
