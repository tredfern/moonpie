-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components", function()
  require "test_helpers.mock_love"
  local Components = require "moonpie.components"

  describe("Empty Component", function()
    it("exists?", function()
      assert.not_nil(Components.none)
    end)
  end)

  describe("Root window component", function()
    it("has the width and height of the window", function()
      assert.equals(love.graphics.getWidth(), Components.root.width)
      assert.equals(love.graphics.getHeight(), Components.root.height)
    end)
  end)
end)
