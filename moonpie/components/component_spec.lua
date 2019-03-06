-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Component", function()
  require "test_helpers.mock_love"
  local Component = require "moonpie.components.component"

  describe("Function components", function()
    it("allows you to pass an initialization function to define the component", function()
      Component("button", function(props) return { foo = props.value } end)
      local new = Component.button({ value = "something" })
      assert.equals("something", new.foo)
    end)

    it("can handle state", function()
      Component("button", function()
        local b = {}
        b.set_value = function(v) b.foo = v end
        return b
      end)

      local b = Component.button()
      b.set_value("Some state")
      assert.equals("Some state", b.foo)
    end)

    it("assigns the name of the component", function()
      Component("button", function() return {} end)
      local s = Component.button()
      assert.equals("button", s.name)
    end)

    describe("Copiable properties", function()
      before_each(function()
        Component("button", function() return {} end)
      end)

      it("style", function()
        local s = Component.button({ style = "some" })
        assert.equals("some", s.style)
      end)

      it("padding", function()
        local p = Component.button({ padding = 5 })
        assert.equals(5, p.padding)
      end)
    end)
  end)
end)
