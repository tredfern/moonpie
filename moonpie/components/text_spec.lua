-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Text", function()
  local text = require("moonpie.components").text

  describe("not great tests but help define changing the code", function()
    it("has a layout geared for text", function()
      local layouts = require "moonpie.layouts"
      local t = text({})
      assert.equals(layouts.text, t.layout)
    end)

    it("has a paint geared for text", function()
      local drawing = require "moonpie.drawing"
      local t = text({})
      assert.equals(drawing.text, t.paint)
    end)
  end)

  it("handles static text", function()
    local t = text{ text = "foobar" }
    assert.equals("foobar", t.text)
  end)

  it("templatizes the text", function()
    local t = text({ text = "Hello {{name}}!", name = "Oskar" })
    assert.equals("Hello Oskar!", t.text)
  end)
end)
