-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("FindByCoordinates", function()
  local find = require "moonpie.find_by_coordinates"
  local node = require "moonpie.node"

  it("returns a node if it's box area contains the coordinates", function()
    local n = node({ width = 100, height = 100 })
    n:layout()
    local results = find(5, 8, n)
    assert.equals(n, results[1])
  end)

  it("returns an empty table if no results are found", function()
    local n = node({ width = 100, height = 100 })
    n:layout()
    local results = find(106, 54, n)
    assert.equals(0, #results)
  end)
end)
