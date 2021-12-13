-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.entities.property", function()
  local Property = require "moonpie.entities.property"

  it("tracks the name for the property", function()
    local p = Property("foo")
    assert.equals("foo", p.name)
  end)
end)