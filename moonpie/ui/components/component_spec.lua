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
        assert.is_true(s:is_hidden())
        s:show()
        assert.is_false(s:is_hidden())
      end)

      it("flags it's been updated", function()
        local s = Component.show_hide()
        s:hide()
        assert.is_true(s:has_updates())
      end)
    end)

    describe("Modifying state/update", function()
      Component("text", function(props) return { text = props.text } end)
      local txt = Component.text({ text = "Hi there!" })
      assert.equals("Hi there!", txt.text)

      it("can be updated and flagged that it has changed", function()
        Component("updates", function() return {
          a = "a", b = "b", c = "c"
        } end)

        local c = Component.updates()
        assert.equals("a", c.a)
        assert.equals("b", c.b)
        assert.equals("c", c.c)
        c:update({ a = "abcd" })
        assert.is_true(c:has_updates())
        assert.equals("abcd", c.a)
      end)
    end)

    describe("Copiable properties", function()
      it("can copy list of properties", function()
        local values = {
          background_color = "red",
          border = 2,
          border_color = "green",
          click = spy.new(function() end),
          color = "blue",
          component_mounted = function() end,
          draw_component = function() end,
          height = 624,
          id = "foo",
          keypressed = spy.new(function() end),
          keyreleased = spy.new(function() end),
          margin = 10,
          padding = 5,
          paint = spy.new(function() end),
          position = "absolute",
          style = "some",
          target_layer = "layer",
          unmount = function() end,
          width = 250
          --do_not_copy = "fail"
        }

        local c = Component.text(values)
        for k, v in pairs(values) do
          assert.equals(v, c[k])
        end
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
        local t1 = b:find_by_id("1")
        local t2 = b:find_by_id(2)
        local t3 = b:find_by_id(3)
        assert.equals("1", t1.text)
        assert.equals("2", t2.text)
        assert.equals("3", t3.text)
      end)

      it("can search it's entire tree that it created", function()
        local b = Component.big()
        local t4 = b:find_by_id(4)
        assert.equals("4", t4.text)
      end)

      it("searchs the child property if present to find_by_id as well", function()
        local b = Component.big()
        local c = { id = "turtles" }
        b.children = { c }
        assert.equals(c, b:find_by_id("turtles"))
      end)
    end)
  end)

  describe("focus management", function()
    it("can have it's focus set", function()
      local UserFocus = require "moonpie.ui.user_focus"
      local c = Component.test()
      c:set_focus()
      assert.equals(c, UserFocus:get_focus())
    end)
  end)

  describe("changing style", function()
    Component("style_test", function() return {} end)

    it("can add styles", function()
      local s = Component.style_test()
      s:add_style("new_style")
      assert.matches("new_style", s.style)
    end)

    it("can remove a style", function()
      local s = Component.style_test({ style = "style1 style2 style3" })
      assert.matches("style1", s.style)
      assert.matches("style2", s.style)
      assert.matches("style3", s.style)

      s:remove_style("style2")
      assert.matches("style1", s.style)
      assert.not_matches("style2", s.style)
      assert.matches("style3", s.style)
    end)
  end)

  it("can add component properties to any table", function()
    local t = { }
    Component.add_component_methods(t)
    assert.not_nil(t.is_hidden)
    assert.equals("function", type(t.is_hidden))
    assert.is_true(t.has_component_methods)
  end)

  it("does not replace the methods if the add component methods is called again", function()
    local t = {}
    Component.add_component_methods(t)
    local m = t.is_hidden
    Component.add_component_methods(t)
    assert.equals(m, t.is_hidden)
  end)

  it("can get it's node from the render engine", function()
    local RenderEngine = require "moonpie.ui.render_engine"
    local comp = Component.button({})
    RenderEngine("ui", comp)

    local node = RenderEngine.find_by_component(comp)
    assert.not_nil(node)
    assert.equals(node, comp:get_node())
    assert.not_nil(comp:get_node())
  end)

  it("can be flagged for removal", function()
    local c = Component.button()
    c:flag_removal()
    assert.is_true(c:needs_removal())
    assert.is_true(c:has_updates())
  end)
end)
