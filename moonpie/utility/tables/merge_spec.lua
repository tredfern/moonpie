-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("merge", function()
  local tables = require "moonpie.utility.tables"

  it("takes properties from two tables and puts them together", function()
    local t = { name = "foxglove", gun = "bigin" }
    local c = { hat = "green", armor = "vest" }

    local out = tables.merge(t, c)
    assert.equals("foxglove", out.name)
    assert.equals("green", out.hat)
    assert.equals("bigin", out.gun)
    assert.equals("vest", out.armor)
  end)

  it("favors the first table if same key", function()
    local t = { name = "boo" }
    local c = { name = "boobie" }
    local out = tables.merge(t, c)
    assert.equals("boo", out.name)
  end)

  it("will treat a table as empty if nil is provided", function()
    assert.equals(0, #tables.merge())
    assert.same({ name = "foo" }, tables.merge({name = "foo" }))
    assert.same({ name = "foo" }, tables.merge(nil, {name = "foo" }))
  end)
end)
