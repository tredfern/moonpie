-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Dropdown", function()
  local components = require "moonpie.components"
  local Node = require "moonpie.node"
  local dd

  before_each(function()
    local menu = components.text({ id = "content", text = "A thing to show" })
    dd = components.dropdown({ caption = "Drop", content = { menu }, width = 100, height = 100 })
    local n = Node(dd)
    n:layout()
  end)

  it("is a button", function()
    local out = dd:render()
    local btn = out:find_by_id("dropdown_btn")
    assert.not_nil(btn)
    assert.equals("Drop", btn.caption)
  end)

  it("Renders a floating element hidden", function()
    local out = dd:render()
    local content = out:find_by_id("dropdown_content")
    assert.is_true(content:is_hidden())
  end)

  it("toggles the visibility of the dropdown content on button click", function()
    local out = dd:render()
    local content = out:find_by_id("dropdown_content")
    local btn = out:find_by_id("dropdown_btn")
    assert.is_true(content:is_hidden())
    btn:click()
    assert.is_false(content:is_hidden())
    btn:click()
    assert.is_true(content:is_hidden())
  end)

  it("updates the floating dropdown whenever it is shown", function()
    local out = dd:render()
    local btn = out:find_by_id("dropdown_btn")
    btn:click()
    local content = out:find_by_id("dropdown_content")
    assert.equals(0, content.x)
    assert.equals(100, content.y)
  end)

  it("removes flags the floating element for removal if unmounted", function()

    local out = dd:render()
    local content = out:find_by_id("dropdown_content")

    dd:unmounted()
    assert.is_true(content:needs_removal())
  end)
end)
