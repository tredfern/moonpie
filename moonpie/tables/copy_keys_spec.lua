-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Copy Keys", function()
  local tables = require "moonpie.tables"

  it("can copy values from one table into another", function()
    local source = { name = "foo", value = 3, skip = "foo" }
    local dest = { skip = "bar" }

    tables.copy_keys(source, dest)
    assert.equals("foo", dest.name)
    assert.equals(3, dest.value)
    assert.equals("bar", dest.skip)
  end)

  it("can be set to overwrite values", function()
    local source = { a = "a", b = "b", c = "c" }
    local dest = { a = 123 }

    tables.copy_keys(source, dest, true)
    assert.equals("a", dest.a)
    assert.equals("b", dest.b)
    assert.equals("c", dest.c)
  end)

  it("does nothing if source is nil", function()
    assert.has_no.errors(function() tables.copy_keys(nil, {}, true) end)
  end)

  it("returns true if it modified the destination", function()
    local s = { a = 1, b = 2 }
    local dest = { }
    assert.is_true(tables.copy_keys(s, dest))
    assert.is_false(tables.copy_keys(s, dest))
  end)
end)
