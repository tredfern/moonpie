-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Button", function()
  local components = require "moonpie.components"

  describe("Basic Properties", function()
    it("has a caption property that is used to set up a text element", function()
      local b = components.button({ caption = "Hello" })
      assert.equals(1, #b)
      assert.equals("Hello", b[1].text)
    end)

    it("supports a click operation", function()
      local s = spy.new(function() end)
      local b = components.button({ caption = "foo", click = s })
      b:click()
      assert.spy(s).was.called.with(b)
    end)
  end)
end)
