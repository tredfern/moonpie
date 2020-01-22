-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("headers", function()
  local components = require "moonpie.ui.components"

  it("can replace text within the headers", function()
    local h1 = components.h1({ text = "Hello {{name}}!", name = "Bob"})
    local h2 = components.h2({ text = "Hello {{name}}!", name = "Bob"})
    local h3 = components.h3({ text = "Hello {{name}}!", name = "Bob"})
    assert.equals("Hello Bob!", h1.text)
    assert.equals("Hello Bob!", h2.text)
    assert.equals("Hello Bob!", h3.text)
  end)
end)