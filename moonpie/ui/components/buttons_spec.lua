-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Button", function()
  local components = require "moonpie.ui.components"

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

    it("centers the text element", function()
      local b = components.button({ caption = "foo" })
      local tb = b:findByID("btn_text")
      assert.not_nil(tb)
      assert.contains("align%-center", tb.style)
    end)
  end)

  it("can templatize the captions", function()
    local b = components.button({ caption = "A {{type}} day", type="big" })
    assert.equals("A big day", b.caption)
  end)

  describe("Image buttons", function()
    it("can have icons passed in", function()
      local b = components.button({
        components.icon({ icon = "expand", id = "btn_icon" })
      })
      assert.not_nil(b:findByID("btn_icon"))
    end)
  end)

  describe("Button Group", function()
    it("adds buttons provided", function()
      local bg = components.button_group({
        buttons = {
          components.button({ caption = "One" }),
          components.button({ caption = "Two" }),
        }
      })

      assert.equals("One", bg[1].caption)
      assert.equals("Two", bg[2].caption)
    end)

    it("if no buttons provided do nothing", function()
      local bg = components.button_group()
      assert.equals(0, #bg)
    end)
  end)
end)
