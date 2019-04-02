-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components", function()
  local Components = require "moonpie.ui.components"

  describe("Root window component", function()
    it("has the width and height of the window", function()
      local r = Components.root()
      assert.equals(love.graphics.getWidth(), r.width)
      assert.equals(love.graphics.getHeight(), r.height)
    end)
  end)
end)
