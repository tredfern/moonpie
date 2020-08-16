-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.indexed", function()
  local tables = require "moonpie.tables"

  it("returns all elements that are indexed", function()
    local a = { 1, 2, 3, 4 }
    assert.array_matches({ 1, 2, 3, 4 }, tables.indexed(a))
  end)
end)