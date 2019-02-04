-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Block", function()
  local box_model = require "moonpie.box_model"
  local Block = require "moonpie.block"

  it("initializes based on the element it's referenced too", function()
    local text_element = { text = "Foo bar" }
    local b = Block(text_element)
    assert.equals(text_element, b.element)
  end)

  it("can have child nodes", function()
    local b = Block()
    local c1, c2 = {}, {}
    b:add(c1, c2)
    assert.equals(c1, b.children[1])
    assert.equals(c2, b.children[2])
  end)

  describe("Layout", function()
    local parent = { width = 152, height = 499 }
    parent.box = box_model(parent)

    it("uses it's parent width to determine it's maximum and defaults to full width", function()
      local b = Block()
      b:layout(parent)
      assert.equals(152, b.box.content.width)
    end)

    it("uses it's own width if provided on the node", function()
      local b = Block({ width = 120 })
      b:layout(parent)
      assert.equals(120, b.box.content.width)
    end)

    it("uses its height if propvided on the node", function()
      local b = Block({ height = 493 })
      b:layout(parent)
      assert.equals(493, b.box.content.height)
    end)

    it("updates the layouts of its children with itself as parent", function()
      local b = Block({ width = 39, height = 39 })
      local params
      local c1 = { layout = function(s, p) params = { s, p } end }
      local no_layout = {}
      b:add(c1, no_layout)
      b:layout(parent)
      assert.equals(c1, params[1])
      assert.equals(b, params[2])
    end)
  end)

  describe("Painting", function()
    local mock_love = require "test_helpers.mock_love"

    it("paints each of its children", function()
      local b = Block()
      local spy_paint = spy.new(function() end)
      local c1 = { paint = spy_paint }
      local c2 = { paint = spy_paint }

      b:add(c1, c2)
      b:paint()
      assert.spy(spy_paint).was.called_with(c1)
      assert.spy(spy_paint).was.called_with(c2)
    end)

    it("paints a background.color for it's area if provided", function()
      mock_love.mock(love.graphics, "setColor", spy.new(function() end))
      mock_love.mock(love.graphics, "rectangle", spy.new(function() end))

      local node = { background = { color = { 1, 1, 1, 1 } }, width = 120, height = 483 }
      local b = Block(node)
      b:layout()

      b:paint()
      --check the background was called

      assert.spy(love.graphics.setColor).was.called_with(node.background.color)
      assert.spy(love.graphics.rectangle).was.called_with("fill", 0, 0, 120, 483)
    end)
  end)
end)
