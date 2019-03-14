-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Copy Keys", function()
  local copy_keys = require "moonpie.copy_keys"

  it("can copy values from one table into another", function()
    local source = { name = "foo", value = 3, skip = "foo" }
    local dest = { skip = "bar" }

    copy_keys(source, dest)
    assert.equals("foo", dest.name)
    assert.equals(3, dest.value)
    assert.equals("bar", dest.skip)
  end)

  it("can be set to overwrite values", function()
    local source = { a = "a", b = "b", c = "c" }
    local dest = { a = 123 }

    copy_keys(source, dest, true)
    assert.equals("a", dest.a)
    assert.equals("b", dest.b)
    assert.equals("c", dest.c)
  end)
end)
