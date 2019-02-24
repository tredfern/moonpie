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

  it("returns all that match the coordinates in order of top, left, down", function()
    local n = node({ width = 200, height = 200 })
    local c1 = node({ width = 100, height = 100 })
    local c2 = node({ width = 100, height = 100 })
    local c1_1 = node({ width = 40, height = 40 })
    n:add(c1, c2)
    c1:add(c1_1)
    n:layout()

    local results = find(5, 8, n)
    assert.equals(n, results[1])
    assert.equals(c1, results[2])
    assert.equals(c1_1, results[3])
  end)

  it("if no children element just skip", function()
    local n = node({ width = 200, height = 200 })
    n:layout()
    -- kind of breaking change but if there are nodes where
    -- children value is destroyed, this simulates it
    n.children = nil
    assert.has_no.errors(function() find(5, 3, n) end)


  end)
end)
