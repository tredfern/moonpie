-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Inline", function()
  local components = require "moonpie.components"

  it("can add components and ensures all their displays are set to inline", function()
    local c1, c2 = { id = "foo" }, { id = "bar" }
    local inline = components.inline({ c1, c2 })
    assert.equals("inline", inline:find_by_id("foo").display)
    assert.equals("inline", inline:find_by_id("bar").display)
  end)
end)
