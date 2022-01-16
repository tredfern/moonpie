-- Copyright (c) 2022 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.collections.array", function()
  local Array = require "moonpie.collections.array"

  it("can be instantiated with a set of dimensions to the array", function()
    local a = Array:new(2)
    assert.equals(2, a.dimensions)
    local b = Array:new(3)
    assert.equals(3, b.dimensions)
  end)

  it("can store and retrieve values at different coordinates", function()
    local a = Array:new(2)
    a(3, 2, "Foo")
    assert.equals("Foo", a(3, 2))
  end)
end)