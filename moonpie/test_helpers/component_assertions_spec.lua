-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.test_helpers.component_assertions", function()
  it("can check if a component is visible", function()
    local components = require "moonpie.ui.components"
    local text = components.text()
    assert.visible(text)
    text:hide()
    assert.not_visible(text)
  end)
end)