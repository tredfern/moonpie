-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Dropdown", function()
  local components = require "moonpie.ui.components"
  local Node = require "moonpie.ui.node"
  local dd

  before_each(function()
    local menu = components.text({ id = "content", text = "A thing to show" })
    dd = components.dropdown({ caption = "Drop", content = { menu }, width = 100, height = 100 })
    local n = Node(dd)
    n:layout()
  end)

  it("is a button", function()
    local out = dd:render()
    local btn = out:findByID("dropdown_btn")
    assert.not_nil(btn)
    assert.equals("Drop", btn.caption)
  end)

  it("Renders a floating element hidden", function()
    local out = dd:render()
    local content = out:findByID("dropdown_content")
    assert.is_true(content:isHidden())
  end)

  it("toggles the visibility of the dropdown content on button click", function()
    local out = dd:render()
    local content = out:findByID("dropdown_content")
    local btn = out:findByID("dropdown_btn")
    assert.is_true(content:isHidden())
    btn:click()
    assert.is_false(content:isHidden())
    btn:click()
    assert.is_true(content:isHidden())
  end)

  it("updates the floating dropdown whenever it is shown", function()
    local out = dd:render()
    local btn = out:findByID("dropdown_btn")
    btn:click()
    local content = out:findByID("dropdown_content")
    assert.equals(0, content.x)
    assert.equals(100, content.y)
  end)

  it("removes flags the floating element for removal if unmounted", function()

    local out = dd:render()
    local content = out:findByID("dropdown_content")

    dd:unmounted()
    assert.is_true(content:needsRemoval())
  end)

  describe("DropdownMenu", function()
    it("can be initialized with a list of options", function()
      local s = spy.new(function() end)
      local dm = components.dropdown_menu({
        caption = "Menu", options = {
          { id = "opt1", caption = "Option 1", click = s },
          { id = "opt2", caption = "Option 2", click = s }
        }
      })

      local opt1 = dm.content:findByID("opt1")
      local opt2 = dm.content:findByID("opt2")
      assert.equals("dropdown_menu_option", opt1.name)
      opt1:click()
      assert.spy(s).was.called.with(opt1)
      opt2:click()
      assert.spy(s).was.called.with(opt2)
    end)
  end)
end)
