-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Renderer", function()
  local Renderer = require "moonpie.renderer"

  describe("Building the tree", function()
    describe("root element", function()
      local renderer = Renderer:new()
      renderer:update()

      it("has an element", function()
        assert.not_nil(renderer.root)
      end)
    end)

    describe("adding children", function()
      local renderer = Renderer:new()

      it("sets all the elements on the root to children of it", function()
        local ele1, ele2, ele3 = { display = "block" }, { display = "block" }, { display = "block" }
        renderer:update(ele1, ele2, ele3)
        assert.equals(3, #renderer.root.children)
      end)
    end)
  end)

  describe("Layout elements", function()
  end)

  describe("Painting", function()
  end)
end)
