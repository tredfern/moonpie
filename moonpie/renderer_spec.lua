-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Renderer", function()
  local mock_love = require "test_helpers.mock_love"
  local Renderer = require "moonpie.renderer"

  describe("Building the tree", function()
    describe("root element", function()
      local renderer = Renderer()

      it("has an element", function()
        assert.not_nil(renderer)
      end)
    end)

    describe("adding children", function()
      it("sets all the elements on the root to children of it", function()
        local ele1, ele2, ele3 = { display = "block" }, { display = "block" }, { display = "block" }
        local r = Renderer(ele1, ele2, ele3)
        assert.equals(3, #r.children)
      end)

      it("adds text elements for a node with a text value associated with it", function()
        local text_block = { display = "block", text = "Some text", font = mock_love.font }
        local r = Renderer(text_block)
        local first_node = r.children[1]
        assert.equals(1, #first_node.children)
      end)
    end)

    describe("deep tree", function()
      local r = Renderer(
      { id = "1",
        { id = "1.1",
          { id = "1.1.1" },
          { id = "1.1.2" }
        }
      },
      {
        id = "2"
      })
      assert.equals("1", r.children[1].element.id)
      assert.equals("2", r.children[2].element.id)
      assert.equals("1.1", r.children[1].children[1].element.id)
      assert.equals("1.1.1", r.children[1].children[1].children[1].element.id)
      assert.equals("1.1.2", r.children[1].children[1].children[2].element.id)
    end)
  end)
end)
