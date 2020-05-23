-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables", function()
  local tables = require "moonpie.tables"

  it("can copy keys", function()
    assert.not_nil(tables.copy_keys)
  end)

  it("can check for keys", function()
    assert.not_nil(tables.has_keys)
  end)

  it("can merge tables", function()
    assert.not_nil(tables.merge)
  end)

end)