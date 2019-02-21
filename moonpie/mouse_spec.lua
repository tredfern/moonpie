-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Mouse", function()
  local mock_love = require "test_helpers.mock_love"
  local node = require "moonpie.node"
  local mouse = require "moonpie.mouse"

  describe("update", function()
    local node_tree = node({ width = 100, height = 100 })
    local n2 = node({ width = 20, height = 20 })
    local n3 = node({ width = 10, height = 10 })
    node_tree:add(n2)
    n2:add(n3)
    node_tree:layout()

    it("updates it's position with the love position", function()
      mock_love.mock(love.mouse, "getPosition", function() return 49, 23 end)
      mouse:update(node({ width = 100, height = 100 }))
      assert.equals(49, mouse.x)
      assert.equals(23, mouse.y)
    end)

    it("can find all elements under the mouse", function()
      mock_love.mock(love.mouse, "getPosition", function() return 12, 12 end)
      mouse:update(node_tree)
      assert.same({ node_tree, n2 }, mouse.over_components)
    end)
  end)
end)
