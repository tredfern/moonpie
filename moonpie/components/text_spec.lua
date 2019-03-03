-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Text", function()
  local text = require("moonpie.components").text

  describe("not great tests but help define changing the code", function()
    it("has a layout geared for text", function()
      local layouts = require "moonpie.layouts"
      assert.equals(layouts.text, text.layout)
    end)

    it("has a paint geared for text", function()
      local renderers = require "moonpie.renderers"
      assert.equals(renderers.text, text.paint)
    end)
  end)
end)
