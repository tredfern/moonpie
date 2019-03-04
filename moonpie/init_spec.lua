-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Initialize Moonpie", function()
  require "test_helpers.mock_love"
  local moonpie = require "moonpie"

  it("has an components base", function()
    assert.not_nil(moonpie.components)
  end)

  it("has a paint", function()
    assert.not_nil(moonpie.paint)
  end)

  it("has a layout method", function()
    assert.not_nil(moonpie.layout)
  end)

  it("has colors", function()
    assert.not_nil(moonpie.colors)
    assert.not_nil(moonpie.colors.red)
  end)

  it("has fonts", function()
    assert.not_nil(moonpie.font)
  end)

  describe("updating", function()
    it("has an update method", function()
      assert.not_nil(moonpie.update)
    end)

    it("updates the mouse each frame if there is a layer", function()
      moonpie.layout({ })
      moonpie.mouse.update = spy.new(function() end)
      moonpie.update()
      assert.spy(moonpie.mouse.update).was.called()
    end)

    it("refreshes the layout of the gui if it is dirty", function()
      local c = moonpie.components("node", { })
      local tree = moonpie.layout(c)
      c:modify({ })
      tree.layout = spy.new(function() end)
      moonpie.update()
      assert.spy(tree.layout).was.called()
    end)
  end)

  describe("layers", function()
    it("has a debug layer that can handle separate ui elements", function()
      local c = moonpie.components("debug_component", {})
      moonpie.render("debug", c)
      assert.not_nil(moonpie.layers.debug)
      moonpie.mouse.update = spy.new(function() end)
      moonpie.layers.debug.paint = spy.new(function() end)
      moonpie.update()
      moonpie.paint()
      assert.spy(moonpie.mouse.update).was.called.with(moonpie.mouse, moonpie.layers.debug)
      assert.spy(moonpie.layers.debug.paint).was.called()
    end)

    it("can add layers to the debug", function()
      local c = moonpie.components("debug_component", {})
      moonpie.render("debug", c)
      assert.equals(c, moonpie.layers.debug.children[1].component)
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
end)
