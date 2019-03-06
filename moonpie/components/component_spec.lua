-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Component", function()
  require "test_helpers.mock_love"
  local Component = require "moonpie.components.component"

  describe("Refactor", function()
    it("allows you to pass an initialization function to define the component", function()
      Component("button", function(props) return { foo = props.value } end)
      local new = Component.button({ value = "something" })
      assert.equals("something", new.foo)
    end)

    it("can handle state", function()
      Component("button", function()
        local b = {}
        b.set_value = function(v) b.foo = v end
        return b
      end)

      local b = Component.button()
      b.set_value("Some state")
      assert.equals("Some state", b.foo)
    end)

    it("copies style properties passed in", function()
      Component("button", function() return {} end)
      local s = Component.button({ style = "some" })
      assert.equals("some", s.style)
    end)

    it("assigns the name of the component", function()
      Component("button", function() return {} end)
      local s = Component.button()
      assert.equals("button", s.name)
    end)
  end)

  describe("Creating", function()
    it("has a name describing the component", function()
      local s = Component("NewComponent")
      assert.equals("NewComponent", s.name)
    end)

    it("can be accessed by doing component.name to access component again", function()
      local s = Component("TestComponentAccess")
      assert.equals(s, Component.TestComponentAccess)
    end)

    it("has properties of the values sent in", function()
      local s = Component("Props", { width = 20, height = 49, color = { 0, 1, 1, 1 } })
      assert.equals(20, s.width)
      assert.equals(49, s.height)
      assert.same({ 0, 1, 1, 1 }, s.color)
    end)

    it("allows for a base component to be set that allows for inheritance", function()
      Component("base", { width = 60, height = 21 })
      Component.base("button", { width = 120 })
      assert.equals(60, Component.base.width)
      assert.equals(21, Component.base.height)
      assert.equals(120, Component.button.width)
      assert.equals(21, Component.button.height)
    end)

    it("if no name is provided it defaults the name to the current name + the next free index", function()
      Component("name", {})
      local name1 = Component.name({})
      local name2 = Component.name({})
      local name3 = Component.name({})
      assert.equals("name1", name1.name)
      assert.equals("name2", name2.name)
      assert.equals("name3", name3.name)
    end)
  end)

  describe("Modifying the component", function()
    it("copies any new/changed keys to the existing component", function()
      local n = Component("modify-test", { text = "Foo" })
      assert.is_nil(n.new)
      n:modify({ text = "bar", new = "some value" })
      assert.equals("bar", n.text)
      assert.equals("some value", n.new)
    end)

    it("flags itself as dirty to notify that it needs to have its layout refreshed", function()
      local c = Component("modify-test", {})
      c:modify({})
      assert.is_true(c.refresh_layout)
    end)
  end)

  describe("Customizing", function()
    -- a strategy allowing generating new components without storing them in a global table for others to reference
    it("Allows taking a component as it's base and then customizing the properties", function()
      local base = Component("Base", { width = 39, height = 20, display = "block" })
      local cust = base("custom1", { width = 50, color = { 1, 1, 1, 1 } })

      assert.equals(50, cust.width)
      assert.equals(39, base.width)
      assert.equals(20, cust.height)
      assert.equals(20, base.height)
      assert.equals("block", base.display)
      assert.equals("block", cust.display)
      assert.same({ 1, 1, 1, 1 }, cust.color)
      assert.is_nil(base.color)
      assert.equals("custom1", cust.name)
    end)

    it("allows customizing the custom component", function()
      local base = Component("Base", { width = 10, height = 50, all = true })
      local cust1 = base("custom1", { width = 49 })
      local cust2 = cust1("custom2", { height = 55 })

      assert.is_true(base.all)
      assert.is_true(cust1.all)
      assert.is_true(cust2.all)
      assert.equals(49, cust2.width)
      assert.equals(55, cust2.height)
    end)
  end)

  it("An component should never return an component from indexing properties by accident", function()
    local base = Component("base")
    base("text")
    local no_text = base("something_else")
    assert.is_nil(no_text.text)
  end)

  describe("Events", function()
    describe("Hover", function()
      it("can have a special component definition defined for when the mouse is hovering over the control", function()
        local e = Component("simple", { a = 1, b = 2, c = 3 }):on_hover({ c = 10 })
        assert.equals(3, e.c)
        assert.equals("simple.hover", e.hover.name)
        assert.equals(1, e.hover.a)
        assert.equals(2, e.hover.b)
        assert.equals(10, e.hover.c)
      end)
    end)

    describe("Click", function()
      it("can be set up with a callback for the click event", function()
        local cb = spy.new(function() end)
        local e = Component("basic"):on_click(cb)
        e:click()
        assert.spy(cb).was.called.with(e)
      end)
    end)
  end)
end)
