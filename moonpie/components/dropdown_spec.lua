-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Dropdown", function()
  local components = require "moonpie.components"

  it("is a button", function()
    local d = components.dropdown({ caption = "Drop" })
    local out = d:render()
    local btn = out:find_by_id("dropdown_btn")
    assert.not_nil(btn)
    assert.equals("Drop", btn.caption)
  end)

  it("Renders a floating element if clicked", function()
    local menu = components.text({ id = "content", text = "A thing to show" })
    local d = components.dropdown({ caption = "Drop", content = { menu } })
    d.box = { region = function() return { left = 3, bottom = 10 } end }
    local out = d:render()
    local btn = out:find_by_id("dropdown_btn")
    btn:click()
    assert.is_true(d.content_visible)
    out = d:render()
    local c = out:find_by_id("dropdown_content")
    assert.not_nil(c)
    assert.equals("floating", c.target_layer)
  end)
end)
