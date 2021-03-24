-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.remove_item", function()
  local removeItem = require "moonpie.tables.remove_item"

  it("pulls an item out that matches that value", function()
    local item = {}
    local tbl = { 1, 2, item, 3, 4 }
    local out = removeItem(tbl, item)
    assert.same({ 1, 2, 3, 4 }, out)
  end)
end)