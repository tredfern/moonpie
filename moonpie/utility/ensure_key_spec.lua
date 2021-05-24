-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.ensure_key", function()
  local ensureKey = require "moonpie.utility.ensure_key"

  it("adds a value to a table if the key is missing", function()
    local t = {}
    ensureKey(t, "foo", {})
    assert.not_nil(t.foo)
  end)

  it("does not change the value if it exists", function()
    local t = { foo = 12345 }
    ensureKey(t, "foo", {})
    assert.equals(12345, t.foo)
  end)
end)