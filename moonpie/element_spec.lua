-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Element", function()
  require "test_helpers.mock_love"
  local Element = require "moonpie.element"

  describe("Creating", function()
    it("has a name describing the element", function()
      local s = Element("NewElement")
      assert.equals("NewElement", s.name)
    end)

    it("can be accessed by doing element.name to access element again", function()
      local s = Element("TestElementAccess")
      assert.equals(s, Element.TestElementAccess)
    end)

    it("has properties of the values sent in", function()
      local s = Element("Props", { width = 20, height = 49, color = { 0, 1, 1, 1 } })
      assert.equals(20, s.width)
      assert.equals(49, s.height)
      assert.same({ 0, 1, 1, 1 }, s.color)
    end)

    it("allows for a base element to be set that allows for inheritance", function()
      Element("base", { width = 60, height = 21 })
      Element.base("button", { width = 120 })
      assert.equals(60, Element.base.width)
      assert.equals(21, Element.base.height)
      assert.equals(120, Element.button.width)
      assert.equals(21, Element.button.height)
    end)

    it("raises an error if there is not a string value provided for the first entry to be it's name", function()
      assert.has_error(function() Element({ "just the table" }) end, "Element requires a name.")
    end)
  end)

  describe("Customizing", function()
    -- a strategy allowing generating new elements without storing them in a global table for others to reference
    it("Allows taking a element as it's base and then customizing the properties", function()
      local base = Element("Base", { width = 39, height = 20, display = "block" })
      local cust = base("custom1", { width = 50, color = { 1, 1, 1, 1 } })

      assert.equals(50, cust.width)
      assert.equals(39, base.width)
      assert.equals(20, cust.height)
      assert.equals(20, base.height)
      assert.equals("block", base.display)
      assert.equals("block", cust.display)
      assert.same({ 1, 1, 1, 1 }, cust.color)
      assert.is_nil(base.color)
      assert.equals("custom1", cust.name)
    end)

    it("allows customizing the custom element", function()
      local base = Element("Base", { width = 10, height = 50, all = true })
      local cust1 = base("custom1", { width = 49 })
      local cust2 = cust1("custom2", { height = 55 })

      assert.is_true(base.all)
      assert.is_true(cust1.all)
      assert.is_true(cust2.all)
      assert.equals(49, cust2.width)
      assert.equals(55, cust2.height)
    end)
  end)

  it("An element should never return an element from indexing properties by accident", function()
    local base = Element("base")
    base("text")
    local no_text = base("something_else")
    assert.is_nil(no_text.text)
  end)

  describe("Special Events", function()
    describe("Hover", function()
      it("can have a special element definition defined for when the mouse is hovering over the control", function()
        local e = Element("simple", { a = 1, b = 2, c = 3 }):on_hover({ c = 10 })
        assert.equals(3, e.c)
        assert.equals("simple.hover", e.hover.name)
        assert.equals(1, e.hover.a)
        assert.equals(2, e.hover.b)
        assert.equals(10, e.hover.c)
      end)
    end)
  end)

  describe("Empty Element", function()
    it("has display set to block", function()
      assert.equals("block", Element.none.display)
    end)
  end)

  describe("Root window element", function()
    it("has the width and height of the window", function()
      assert.equals(love.graphics.getWidth(), Element.root.width)
      assert.equals(love.graphics.getHeight(), Element.root.height)
      assert.equals("block", Element.root.display)
    end)
  end)
end)
