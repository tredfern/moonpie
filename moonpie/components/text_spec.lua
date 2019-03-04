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

  describe("it can perform some templating of text", function()
    local node = require "moonpie.node"
    local t = text("say_hello", { text = "Hello {{name}}!", font = {} })
    t({ name = "Oskar!" })
    local n = node(t)
    local p = node({ width = 100 })
    n:layout(p)
  end)
end)
