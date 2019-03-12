-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Initialize Moonpie", function()
  require "moonpie.test_helpers.mock_love"
  local moonpie = require "moonpie"

  it("has an components base", function()
    assert.not_nil(moonpie.components)
  end)

  it("has a paint", function()
    assert.not_nil(moonpie.paint)
  end)

  it("has a render method", function()
    assert.not_nil(moonpie.render)
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
      moonpie.render("ui", { })
      moonpie.mouse.update = spy.new(function() end)
      moonpie.update()
      assert.spy(moonpie.mouse.update).was.called()
    end)

    it("refreshes the layout of the gui if it is dirty", function()
      local c = { }
      local tree = moonpie.render("ui", c)
      c.refresh_layout = true
      tree.layout = spy.new(function() end)
      moonpie.update()
      assert.spy(tree.layout).was.called()
    end)
  end)

  describe("layers", function()
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
      assert.not_nil(moonpie.styles.button)
    end)
  end)
end)
