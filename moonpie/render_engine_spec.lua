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

  describe("Building the tree", function()
    describe("root component", function()
      local render_engine = RenderEngine()

      it("has an component", function()
        assert.not_nil(render_engine)
      end)
    end)

    describe("adding children", function()
      it("sets all the components on the root to children of it", function()
        local ele1, ele2, ele3 = { }, { }, { }
        local r = RenderEngine(ele1, ele2, ele3)
        assert.equals(3, #r.root.children)
      end)

      it("assigns the parent", function()
        local c = { }
        local p = { c }
        local r = RenderEngine(p)
        assert.equals(r.root, r.root.children[1].parent)
        assert.equals(r.root.children[1], r.root.children[1].children[1].parent)
      end)
    end)

    describe("deep tree", function()
      local r = RenderEngine(
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
      local r = RenderEngine(c)
      local node = r:find_by_component(c)
      assert.equals(c, node.component)
    end)
  end)

  describe("Paint", function()
    it("delegates to root", function()
      local r = RenderEngine({})
      r.root.paint = spy.new(function() end)
      r:paint()
      assert.spy(r.root.paint).was.called()
    end)

    it("refreshes the style information before painting", function()
      local c = Component.complex()
      local r = RenderEngine(c)
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
      local r = RenderEngine(c)

      -- nodes should be Root -> Complex (c) -> text = "foo"
      assert.equals("complex", r.root.children[1].text)
      assert.equals("foo", r.root.children[1].children[1].text)
    end)
  end)

  describe("Updating", function()
    describe("Refreshing", function()
      it("will rerender child output if the component is flagged for updates and has a render method", function()
        local c = Component.complex()
        local r = RenderEngine(c)
        c:update({ value = 10 })
        r:update(Mouse)
        assert.equals(10, r.root.children[1].children[1].value)
        assert.is_false(c:has_updates())
      end)

      it("updates the layout of the newly rendered children", function()
        local c = Component.complex()
        local r = RenderEngine(c)
        local n = r:find_by_component(c)
        n.layout = spy.new(function() end)
        c:update({ value = 10 })
        r:update(Mouse)
        assert.spy(n.layout).was.called()
      end)

      it("will not render components that are hidden", function()
        local c = Component.complex()
        local r = RenderEngine(c)
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
        local r = RenderEngine({})
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
      local rend = RenderEngine(c)
      assert.equals(rend, RenderEngine.layers.ui)
    end)

    it("can render to a specific layer", function()
      local c = Component.complex()
      local rend = RenderEngine:render_all("debug", c)
      assert.equals(rend, RenderEngine.layers.debug)
    end)

    it("orders the layers ui, modal, floating, debug", function()
      local ui = RenderEngine:render_all("ui", {})
      local debug = RenderEngine:render_all("debug", {})
      local floating = RenderEngine:render_all("floating", {})
      local modal = RenderEngine:render_all("modal", {})

      assert.same({ ui, modal, floating, debug }, RenderEngine:ordered_layers())
    end)
  end)
end)
