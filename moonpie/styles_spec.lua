-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
--
--
-- Each node will parse the style whenever the node is flagged as dirty (first time or other event)
-- Style will be cached per node at that point
-- Node will go from component up through the styles specified building a table of values
-- That style table will be used from then on to represent the computed values of the element
--
-- component = components.text({ style = "success flashing", padding = 20 })
-- style { component values are assigned first }
-- followed by success styles but only for values that are not already assigned
-- followed by flashing styles but only for values that are not already assigned
-- followed by parent node style properties that are inheritable

describe("Styles", function()
  local styles = require("moonpie.styles")

  it("can accept many different properties", function()
    styles.add("text", {
      padding = 10,
      margin = 10
    })
    assert.equals(10, styles.text.padding)
    assert.equals(10, styles.text.margin)
  end)

  describe("computing styles", function()
    before_each(function()
      styles.add("button", { font_size = 10, color = "red" })
      styles.add("button-primary", { color = "green" })
    end)

    it("single style just uses that style", function()
      local c = { style = "button" }
      local s = styles.compute(c)
      assert.equals(10, s.font_size)
      assert.equals("red", s.color)
    end)

    it("figures out style right to left in the style property", function()
      local c = { style = "button button-primary" }
      local s = styles.compute(c)
      assert.equals(10, s.font_size)
      assert.equals("green", s.color)
    end)

    it("favors the component's property above any styles", function()
      local c = { style = "button button-primary", color = "blue", font_size = 5, width = 100 }
      local s = styles.compute(c)
      assert.equals(5, s.font_size)
      assert.equals("blue", s.color)
      assert.equals(100, s.width)
    end)

    it("returns nil if the property does not exist", function()
      local s = styles.compute({})
      assert.is_nil(s.width)
    end)

    it("looks for a style matching the name if component has a name", function()
      local c = { name = "button", style = "button-primary" }
      local s = styles.compute(c)
      assert.equals(10, s.font_size)
      assert.equals("green", s.color)
    end)

    describe("inherited properties", function()
      it("pulls color from the parent", function()
        local p = { style = "button" }
        local ps = styles.compute(p)
        local c = { }
        local s = styles.compute(c, ps)
        assert.equals("red", s.color)
      end)

      it("pulls font", function()
        styles.text = { font = "font-stuff" }
        local p = { style = "text" }
        local c = { }
        local s = styles.compute(c, styles.compute(p))
        assert.equals("font-stuff", s.font)
      end)

      it("pulls parent component properties too", function()
        local p = { color = "red" }
        local ps = styles.compute(p)
        local s = styles.compute({}, ps)
        assert.equals("red", s.color)
      end)

      it("does not pull width from the parent", function()
        local p = { width = 100 }
        local ps = styles.compute(p)
        local c = {}
        local s = styles.compute(c, ps)
        assert.equals(100, ps.width)
        assert.is_nil(s.width)
      end)
    end)

    describe("conditional styles", function()
      describe("hover", function()
        styles.text = { color = "blue", _hover_ = { color = "green" } }
        local item = { style = "text" }
        local parent = {}
        local s = styles.compute(item, parent, { hover = false })
        assert.equals("blue", s.color)
        s = styles.compute(item, parent, { hover = true })
        assert.equals("green", s.color)
      end)
    end)
  end)
end)
