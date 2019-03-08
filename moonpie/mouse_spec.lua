-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Mouse", function()
  local mock_love = require "moonpie.test_helpers.mock_love"
  local node = require "moonpie.node"
  local mouse = require "moonpie.mouse"

  describe("initial state", function()
    it("has no components over", function()
      assert.is_nil(mouse.over_components)
    end)

    it("has no mouse button down components", function()
      assert.is_nil(mouse.button_down_components[1])
    end)
  end)

  describe("update", function()
    local node_tree, n2, n3

    before_each(function()
      mock_love.reset_mouse()

      node_tree = node({ name = "root", width = 100, height = 100 })
      n2 = node({ name = "level1", width = 20, height = 20, click = spy.new(function() end) })
      n3 = node({ name = "level2", width = 10, height = 10 })

      node_tree:add(n2)
      n2:add(n3)
      node_tree:layout()
    end)

    it("can find all elements under the mouse", function()
      mock_love.move_mouse(12, 12)
      mouse:update(node_tree)
      assert.same({ node_tree, n2 }, mouse.over_components)

      mock_love.move_mouse(3, 3)
      mouse:update(node_tree)
      assert.same({ node_tree, n2, n3 }, mouse.over_components)
    end)

    describe("Click Event", function()
      it("logs the components that it was over when down was started", function()
        mock_love.move_mouse(5, 5)
        mock_love.simulate_button_down(1)
        mouse:update(node_tree)
        assert.same({ node_tree, n2, n3 }, mouse.button_down_components[1])
      end)

      it("keeps the same button_down_components even if the mouse moves if the mouse is not released", function()
        mock_love.move_mouse(5, 5)
        mock_love.simulate_button_down(1)
        mouse:update(node_tree)
        local cache = mouse.button_down_components[1]
        mock_love.move_mouse(150, 150)
        mouse:update(node_tree)
        assert.equals(cache, mouse.button_down_components[1])
      end)

      it("triggers the click handler of the lowest node in the tree on release of button", function()
        mock_love.move_mouse(5, 5)
        mock_love.simulate_button_down(1)
        mouse:update(node_tree)
        mock_love.simulate_button_up(1)
        mouse:update(node_tree)
        assert.spy(n2.click).was.called.with(n2)
      end)
    end)
  end)
end)
