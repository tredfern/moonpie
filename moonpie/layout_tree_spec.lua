-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("LayoutTree", function()
  local mock_love = require "test_helpers.mock_love"
  local LayoutTree = require "moonpie.layout_tree"

  describe("Building the tree", function()
    describe("root component", function()
      local layout_tree = LayoutTree()

      it("has an component", function()
        assert.not_nil(layout_tree)
      end)
    end)

    describe("adding children", function()
      it("sets all the components on the root to children of it", function()
        local ele1, ele2, ele3 = { }, { }, { }
        local r = LayoutTree(ele1, ele2, ele3)
        assert.equals(3, #r.children)
      end)

      it("adds text components for a node with a text value associated with it", function()
        local text_node = { text = "Some text", font = mock_love.font }
        local r = LayoutTree(text_node)
        local first_node = r.children[1]
        assert.equals(1, #first_node.children)
      end)
    end)

    describe("deep tree", function()
      local r = LayoutTree(
      { id = "1",
        { id = "1.1",
          { id = "1.1.1" },
          { id = "1.1.2" }
        }
      },
      {
        id = "2"
      })
      assert.equals("1", r.children[1].component.id)
      assert.equals("2", r.children[2].component.id)
      assert.equals("1.1", r.children[1].children[1].component.id)
      assert.equals("1.1.1", r.children[1].children[1].children[1].component.id)
      assert.equals("1.1.2", r.children[1].children[1].children[2].component.id)
    end)
  end)
end)
