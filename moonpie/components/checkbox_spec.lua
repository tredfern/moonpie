-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Checkbox", function()
  local components = require "moonpie.components"

  it("has a checkbox component and a label", function()
    local cb = components.checkbox({ caption = "Toggle1" })
    local out = cb:render()
    local check = out:find_by_id("cb_check")
    local label = out:find_by_id("cb_label")
    assert.not_nil(check, "Should have a checkbox component")
    assert.not_nil(label, "Should have a label component")

    assert.equals("", check.text)
    assert.equals("Toggle1", label.text)
  end)

  it("can be set to be checked initially", function()
    local cb = components.checkbox({ caption = "Toggle1", value = true })
    local out = cb:render()
    local check = out:find_by_id("cb_check")
    assert.equals("√", check.text)
  end)

  it("when clicked it updates it's value with the opposite of what it was", function()
    local cb = components.checkbox({ caption = "check" })
    assert.is_false(cb.value)
    cb:click()
    assert.is_true(cb.value)
    cb:click()
    assert.is_false(cb.value)
  end)
end)
