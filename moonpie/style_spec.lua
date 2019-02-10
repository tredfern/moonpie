-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Style", function()
  require "test_helpers.mock_love"
  local Style = require "moonpie.style"

  describe("Creating", function()
    it("has a name describing the style", function()
      local s = Style("NewStyle")
      assert.equals("NewStyle", s.name)
    end)

    it("can be accessed by doing style.name to access style again", function()
      local s = Style("TestStyleAccess")
      assert.equals(s, Style.TestStyleAccess)
    end)

    it("has properties of the values sent in", function()
      local s = Style("Props", { width = 20, height = 49, color = { 0, 1, 1, 1 } })
      assert.equals(20, s.width)
      assert.equals(49, s.height)
      assert.same({ 0, 1, 1, 1 }, s.color)
    end)

    it("allows for a base style to be set that allows for inheritance", function()
      Style("base", { width = 60, height = 21 })
      Style("button", { width = 120 }, Style.base)
      assert.equals(60, Style.base.width)
      assert.equals(21, Style.base.height)
      assert.equals(120, Style.button.width)
      assert.equals(21, Style.button.height)
    end)
  end)

  describe("Customizing", function()
    -- a strategy allowing generating new styles without storing them in a global table for others to reference
    it("Allows taking a style as it's base and then customizing the properties", function()
      local base = Style("Base", { width = 39, height = 20, display = "block" })
      local cust = base:customize{ width = 50, color = { 1, 1, 1, 1 } }

      assert.equals(50, cust.width)
      assert.equals(39, base.width)
      assert.equals(20, cust.height)
      assert.equals(20, base.height)
      assert.equals("block", base.display)
      assert.equals("block", cust.display)
      assert.same({ 1, 1, 1, 1 }, cust.color)
      assert.is_nil(base.color)
      assert.equals("Base.custom", cust.name)
    end)

    it("allows customizing the custom style", function()
      local base = Style("Base", { width = 10, height = 50, all = true })
      local cust1 = base:customize({ width = 49 })
      local cust2 = cust1:customize({ height = 55 })

      assert.is_true(base.all)
      assert.is_true(cust1.all)
      assert.is_true(cust2.all)
      assert.equals(49, cust2.width)
      assert.equals(55, cust2.height)
    end)
  end)

  describe("Empty Style", function()
    it("has display set to block", function()
      assert.equals("block", Style.none.display)
    end)
  end)

  describe("Root window style", function()
    it("has the width and height of the window", function()
      assert.equals(love.graphics.getWidth(), Style.root.width)
      assert.equals(love.graphics.getHeight(), Style.root.height)
      assert.equals("block", Style.root.display)
    end)
  end)
end)
