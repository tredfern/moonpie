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

    it("has a caption property that is used to set up a text element", function()
      local b = components.button({ caption = "Hello" })
      assert.equals(1, #b)
      assert.equals("Hello", b[1].text)
    end)
  end)
end)
