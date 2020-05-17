-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.tables.assign", function()
  local tables = require "moonpie.utility.tables"

  it("copies groups of objects in sequence to destination", function()
    local t1 = { a = 2, b = 3, c = "foo" }
    local t2 = { 1, 2, 3, 4 }
    local t3 = { a = 6 }
    local t4 = { 7, 8 }

    local dest = {}

    local test = tables.assign(dest, t1, t2, t3, t4)
    assert.equals(dest, test)

    assert.equals(6, test.a)
    assert.equals(3, test.b)
    assert.equals("foo", test.c)
    assert.equals(7, test[1])
    assert.equals(8, test[2])
    assert.equals(3, test[3])
    assert.equals(4, test[4])

  end)
end)