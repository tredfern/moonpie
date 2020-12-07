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

  it("can check if a component is contained within render", function()
    local components = require "moonpie.ui.components"
    local c = components("sample", function() return {
      components.h1(),
      components.text()
    } end)
    local sample = c()

    assert.contains_component("h1", sample)
    assert.contains_component("text", sample)
    assert.not_contains_component("foo", sample)
  end)

  it("can check if a component is contained within that matches an id", function()
    local components = require "moonpie.ui.components"
    local c = components("sample", function() return {
      components.text { id = "text123" },
      components.text { id = "text345" }
    } end)
    local sample = c()

    assert.contains_component_with_id("text123", sample)
    assert.contains_component_with_id("text345", sample)
    assert.not_contains_component_with_id("text", sample)
  end)
end)