-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.ui.components.p", function()
  local components = require "moonpie.ui.components"

  it("takes text and wraps it in an empty tag", function()
    local p = components.p("I'm some text")
    assert.equals("I'm some text", p[1].text)
  end)

  it("will use the text property if passed a table", function()
    local p = components.p({ text = "I'm some text" })
    assert.equals("I'm some text", p[1].text)
  end)
end)