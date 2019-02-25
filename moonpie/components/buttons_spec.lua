-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Button", function()
  local components = require "moonpie.components"

  describe("Basic Properties", function()
    it("is an inline layout", function()
      assert.equals("inline", components.button.display)
    end)
  end)
end)
