-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("RenderEngine", function()
  local RenderEngine = require "moonpie.render_engine"

  describe("Building the tree", function()
    describe("root component", function()
      local layout_tree = RenderEngine()

      it("has an component", function()
        assert.not_nil(layout_tree)
      end)
    end)

    describe("adding children", function()
      it("sets all the components on the root to children of it", function()
        local ele1, ele2, ele3 = { }, { }, { }
        local r = RenderEngine(ele1, ele2, ele3)
        assert.equals(3, #r.children)
      end)

      it("assigns the parent", function()
        local c = { }
        local p = { c }
        local r = RenderEngine(p)
        assert.equals(r, r.children[1].parent)
        assert.equals(r.children[1], r.children[1].children[1].parent)
      end)
    end)

    describe("deep tree", function()
      local r = RenderEngine(
      { id = "1",
        { id = "1.1",
          { id = "1.1.1" },
          { id = "1.1.2" }
        }
      },
      {
        id = "2"
      })
      assert.equals("1", r.children[1].id)
      assert.equals("2", r.children[2].id)
      assert.equals("1.1", r.children[1].children[1].id)
      assert.equals("1.1.1", r.children[1].children[1].children[1].id)
      assert.equals("1.1.2", r.children[1].children[1].children[2].id)
    end)
  end)
end)
