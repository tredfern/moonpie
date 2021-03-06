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

    it("updates the mouse each frame", function()
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

        moonpie.events.beforeUpdate:add(spy_to_func(before_spy))
        moonpie.events.afterUpdate:add(spy_to_func(after_spy))
        moonpie.update()

        assert.spy(before_spy).was.called()
        assert.spy(after_spy).was.called()
      end)
    end)

    describe("paint", function()
      it("calls registered events", function()
        local after_spy = spy.new(function() end)
        local before_spy = spy.new(function() end)

        moonpie.events.beforePaint:add(spy_to_func(before_spy))
        moonpie.events.afterPaint:add(spy_to_func(after_spy))
        moonpie.paint()

        assert.spy(before_spy).was.called()
        assert.spy(after_spy).was.called()
      end)
    end)

    describe("resize", function()
      it("calls registered events with new width and height", function()
        local evt = spy.new(function() end)

        moonpie.events.windowResize:add(spy_to_func(evt))
        moonpie.resize(400, 300)
        assert.spy(evt).was.called_with(400, 300)
      end)
    end)
  end)

  describe("Keyboard integrations", function()
    it("relays keyPressed events", function()
      moonpie.keyboard.keyPressed = spy.new(function() end)
      moonpie.keyPressed("key", "scancode", "isrepeat")
      assert.spy(moonpie.keyboard.keyPressed).was.called_with(moonpie.keyboard, "key", "scancode", "isrepeat")
    end)

    it("relays keyReleased events", function()
      moonpie.keyboard.keyReleased = spy.new(function() end)
      moonpie.keyReleased("key", "scancode")
      assert.spy(moonpie.keyboard.keyReleased).was.called_with(moonpie.keyboard, "key", "scancode")
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

  it("has a module for csv file support", function()
    assert.not_nil(moonpie.utility.csv)
  end)

  it("testRender will return a rendered version of a component", function()
    local c = moonpie.ui.components.text { id = "foo", mounted = spy.new(function() end) }
    local node = moonpie.testRender(c)
    assert.not_nil(node:findByID("foo"))
    assert.spy(c.mounted).was.called()
  end)
end)
