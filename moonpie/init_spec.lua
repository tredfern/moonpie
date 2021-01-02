-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Initialize Moonpie", function()
  require "moonpie.test_helpers.mock_love"
  local moonpie = require "moonpie"

  it("has an components base", function()
    assert.not_nil(moonpie.ui.components)
  end)

  it("has a paint", function()
    assert.not_nil(moonpie.paint)
  end)

  it("has a render method", function()
    assert.not_nil(moonpie.render)
  end)

  it("has colors", function()
    assert.not_nil(moonpie.graphics.colors)
    assert.not_nil(moonpie.graphics.colors.red)
  end)

  it("has fonts", function()
    assert.not_nil(moonpie.graphics.font)
  end)

  it("supports images", function()
    assert.not_nil(moonpie.graphics.image)
  end)

  it("supports a basic class prototype implementation", function()
    assert.not_nil(moonpie.class)
  end)

  describe("updating", function()
    it("has an update method", function()
      assert.not_nil(moonpie.update)
    end)

    it("updates the mouse each frame if there is a layer", function()
      moonpie.render("ui", { })
      moonpie.mouse.update = spy.new(function() end)
      moonpie.update()
      assert.spy(moonpie.mouse.update).was.called()
    end)
  end)

  describe("events", function()
    describe("updates", function()
      it("calls registered updates", function()
        local after_spy = spy.new(function() end)
        local before_spy = spy.new(function() end)

        moonpie.events.before_update:add(spy_to_func(before_spy))
        moonpie.events.after_update:add(spy_to_func(after_spy))
        moonpie.update()

        assert.spy(before_spy).was.called()
        assert.spy(after_spy).was.called()
      end)
    end)

    describe("paint", function()
      it("calls registered events", function()
        local after_spy = spy.new(function() end)
        local before_spy = spy.new(function() end)

        moonpie.events.before_paint:add(spy_to_func(before_spy))
        moonpie.events.after_paint:add(spy_to_func(after_spy))
        moonpie.paint()

        assert.spy(before_spy).was.called()
        assert.spy(after_spy).was.called()
      end)
    end)

    describe("resize", function()
      it("calls registered events with new width and height", function()
        local evt = spy.new(function() end)

        moonpie.events.window_resize:add(spy_to_func(evt))
        moonpie.resize(400, 300)
        assert.spy(evt).was.called_with(400, 300)
      end)
    end)
  end)

  describe("Keyboard integrations", function()
    it("relays keypressed events", function()
      moonpie.keyboard.keypressed = spy.new(function() end)
      moonpie.keypressed("key", "scancode", "isrepeat")
      assert.spy(moonpie.keyboard.keypressed).was.called_with(moonpie.keyboard, "key", "scancode", "isrepeat")
    end)

    it("relays keyreleased events", function()
      moonpie.keyboard.keyreleased = spy.new(function() end)
      moonpie.keyreleased("key", "scancode")
      assert.spy(moonpie.keyboard.keyreleased).was.called_with(moonpie.keyboard, "key", "scancode")
    end)
  end)

  describe("Render Engine / DOM", function()
    it("has access to the current engine", function()
      assert.equals(require("moonpie.ui.render_engine"), moonpie.ui.current)
    end)
  end)

  describe("Collections", function()
    it("has list, deque, queue, priority_queue, stack, and union_find available", function()
      assert.not_nil(moonpie.collections.list)
      assert.not_nil(moonpie.collections.deque)
      assert.not_nil(moonpie.collections.queue)
      assert.not_nil(moonpie.collections.priority_queue)
      assert.not_nil(moonpie.collections.stack)
      assert.not_nil(moonpie.collections.union_find)
    end)
  end)

  describe("Stylesheets", function()
    it("loads the stylesheet", function()
      assert.not_nil(moonpie.ui.styles.button)
    end)
  end)

  describe("ecs", function()
    it("has the ecs world", function()
      assert.not_nil(moonpie.ecs.world)
    end)
  end)

  it("has a module for csv file support", function()
    assert.not_nil(moonpie.utility.csv)
  end)

  it("test_render will return a rendered version of a component", function()
    local c = moonpie.ui.components.text { id = "foo", mounted = spy.new(function() end) }
    local node = moonpie.test_render(c)
    assert.not_nil(node:find_by_id("foo"))
    assert.spy(c.mounted).was.called()
  end)
end)
