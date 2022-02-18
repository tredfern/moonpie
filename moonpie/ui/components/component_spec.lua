-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Component", function()
  local Component = require "moonpie.ui.components.component"
    Component("test", function() return { } end)

  describe("Function components", function()
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

    it("assigns the name of the component", function()
      Component("button", function() return {} end)
      local s = Component.button()
      assert.equals("button", s.name)
    end)

    describe("show/hide", function()
      before_each(function()
        Component("show_hide", function() return {} end)
      end)

      it("can show and hide the component", function()
        local s = Component.show_hide()
        s:hide()
        assert.is_true(s:isHidden())
        s:show()
        assert.is_false(s:isHidden())
      end)

      it("flags it's been updated", function()
        local s = Component.show_hide()
        s:hide()
        assert.is_true(s:hasUpdates())
      end)
    end)

    describe("Modifying state/update", function()
      Component("text", function(props) return { text = props.text } end)
      local txt = Component.text({ text = "Hi there!" })
      assert.equals("Hi there!", txt.text)

      Component("updates", function() return {
        a = "a", b = "b", c = "c"
      } end)

      it("can be updated and flagged that it has changed", function()

        local c = Component.updates()
        assert.equals("a", c.a)
        assert.equals("b", c.b)
        assert.equals("c", c.c)
        c:update({ a = "abcd" })
        assert.is_true(c:hasUpdates())
        assert.equals("abcd", c.a)
      end)

      it("does not flag it's been updated if all the properties are the same", function()
        local c = Component.updates()
        c:update{ a = "a", b = "b", c = "c" }
        assert.is_falsy(c:hasUpdates())
      end)

      it("adds to the update queue after updating", function()
        local update_queue = require "moonpie.ui.update_queue"
        update_queue:clear()
        local c = Component.updates()
        c:update { a = "abcd" }
        assert.equals(c, update_queue[1])
      end)

      it("can force an update if necessary", function()
        local updateQueue = require "moonpie.ui.update_queue"
        updateQueue:clear()
        local c= Component.updates()
        c:forceRefresh()
        assert.equals(c, updateQueue[1])
        assert.is_true(c:hasUpdates())
      end)

      it("can trigger a callback when it's been updated", function()
        local cb = spy.new(function() end)
        local c = Component.updates { onUpdate = cb }
        local change = { a = "abcd" }
        c:update(change)
        assert.spy(cb).was.called_with(c, change)
      end)
    end)

    describe("Copiable properties", function()
      it("can copy list of properties", function()
        local values = {
          backgroundColor = "red",
          border = 2,
          borderColor = "green",
          click = spy.new(function() end),
          clickSound = {},
          color = "blue",
          data = {},
          mounted = function() end,
          drawComponent = function() end,
          fontName = "Arial",
          fontSize = 18,
          height = 624,
          hidden = true,
          id = "foo",
          keyPressed = spy.new(function() end),
          keyReleased = spy.new(function() end),
          margin = 10,
          mouseDown = spy.new(function() end),
          onMouseMove = function() end,
          mouseUp = spy.new(function() end),
          padding = 5,
          paint = spy.new(function() end),
          position = "absolute",
          style = "some",
          targetLayer = "layer",
          textwrap = "wrapping",
          unmounted = function() end,
          width = 250
          --do_not_copy = "fail"
        }

        local c = Component.text(values)
        for k, v in pairs(values) do
          assert.equals(v, c[k])
        end
      end)

      it("can use templating in copy properties to make assigning ids or styles easier", function()
        local c = Component.text { id = "{{tricky}}_value_id", tricky = 123 }
        assert.equals("123_value_id", c.id)
      end)
    end)

    describe("finding children", function()
      before_each(function()
        Component("text", function(props) return { text = props.text } end)
        Component("big", function()
          return {
            Component.text({ id = "1", text = "1" }),
            Component.text({ id = 2, text = "2" }),
            Component.text({ id = 3, text = "3" }),
            {
              Component.text({ id = 4, text = "4" })
            }
          }
        end)
      end)

      it("can find child components if an id is provided", function()
        local b = Component.big()
        local t1 = b:findByID("1")
        local t2 = b:findByID(2)
        local t3 = b:findByID(3)
        assert.equals("1", t1.text)
        assert.equals("2", t2.text)
        assert.equals("3", t3.text)
      end)

      it("can search it's entire tree that it created", function()
        local b = Component.big()
        local t4 = b:findByID(4)
        assert.equals("4", t4.text)
      end)

      it("searchs the child property if present to findByID as well", function()
        local b = Component.big()
        local c = { id = "turtles" }
        b.children = { c }
        assert.equals(c, b:findByID("turtles"))
      end)

      it("can find all components by name", function()
        local b = Component.big()
        local texts = b:findAllByName("text")
        assert.equals(4, #texts)
      end)
    end)
  end)

  describe("focus management", function()
    it("can have it's focus set", function()
      local UserFocus = require "moonpie.ui.user_focus"
      local c = Component.test()
      c:setFocus()
      assert.equals(c, UserFocus:getFocus())
    end)

    it("can be blurred from focus", function()
      local UserFocus = require "moonpie.ui.user_focus"
      local c = Component.test()
      c:setFocus()
      c:blur()
      assert.is_nil(UserFocus:getFocus())
    end)
  end)

  describe("changing style", function()
    Component("style_test", function() return {} end)

    it("can add styles", function()
      local s = Component.style_test()
      s:addStyle("new_style")
      assert.matches("new_style", s.style)
    end)

    it("can remove a style", function()
      local s = Component.style_test({ style = "style1 style2 style3" })
      assert.matches("style1", s.style)
      assert.matches("style2", s.style)
      assert.matches("style3", s.style)

      s:removeStyle("style2")
      assert.matches("style1", s.style)
      assert.not_matches("style2", s.style)
      assert.matches("style3", s.style)
    end)
  end)

  it("can add component properties to any table", function()
    local t = { }
    Component.addComponentMethods(t)
    assert.not_nil(t.isHidden)
    assert.equals("function", type(t.isHidden))
    assert.is_true(t.hasComponentMethods)
  end)

  it("does not replace the methods if the add component methods is called again", function()
    local t = {}
    Component.addComponentMethods(t)
    local m = t.isHidden
    Component.addComponentMethods(t)
    assert.equals(m, t.isHidden)
  end)

  it("can get it's node from the render engine", function()
    local RenderEngine = require "moonpie.ui.render_engine"
    local comp = Component.button({})
    RenderEngine("ui", comp)

    local node = RenderEngine.findByComponent(comp)
    assert.not_nil(node)
    assert.equals(node, comp:getNode())
    assert.not_nil(comp:getNode())
  end)

  it("can be flagged for removal", function()
    local c = Component.button()
    c:flagRemoval()
    assert.is_true(c:needsRemoval())
    assert.is_true(c:hasUpdates())
  end)

  it("can use remove component", function()
    local c = Component.button()
    c:remove()
    assert.is_true(c:needsRemoval())
    assert.is_true(c:hasUpdates())
  end)

  it("returns decipherable error if component render function is not set up properly", function()
    Component("bad_component", function() end)
    assert.has_errors(Component.bad_component, "Component did not initialize.")
  end)

  it("provides easy access to the logger", function()
    local logger = require "moonpie.logger"
    logger:clear()
    Component("logging", function() return { log = function(self) self.logger.debug("Hooray") end } end)
    local l = Component.logging()

    l:log()
    assert.equals("Hooray", logger.entries[1].message)

  end)

  it("returns the function that is used to create component", function()
    local f = Component("super_cool", function() return {} end)
    assert.equals(Component.super_cool, f)
  end)

  describe("new-creation-scheme", function()
    it("can define component creation function without factory model", function()
      local funky = Component("funky", function(props)
        return {
          a = props.a
        }
      end)
      local instance = funky({ a = "test", color = "green" })
      assert.equals("test", instance.a)
      assert.equals("green", instance.color)
    end)
  end)

  describe("simple function components", function()
    it("can create a component that just returns a render function", function()
      local func = Component("func", function()
        return function(self)
          return { self.a, self.b }
        end
      end)

      local funcInstance = func({ a = 1, b = 2 })
      assert.equals(1, funcInstance.a)
      assert.equals(2, funcInstance.b)
      local render = funcInstance:render()
      assert.array_matches({ 1, 2 }, render)
    end)
  end)
end)