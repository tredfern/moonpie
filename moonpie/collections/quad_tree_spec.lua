-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.collections.quad_tree", function()
  local quad_tree = require "moonpie.collections.quad_tree"

  it("is configured with width, height and max depth", function()
    local qt = quad_tree:new { width = 800, height = 500, max_depth = 5 }
    assert.equals(800, qt.width)
    assert.equals(500, qt.height)
    assert.equals(5, qt.max_depth)
  end)

  it("can add items to the quad tree", function()
    local qt = quad_tree:new { width = 100, height = 100, max_depth = 3 }
    local thing = { x = 10, y = 10, width = 20, height = 20 }
    qt:add(thing)
  end)

  it("can get items that overlap some range", function()
    local qt = quad_tree:new { width = 100, height = 100, max_depth = 3 }
    local thing = { x = 10, y = 10, width = 20, height = 20 }
    qt:add(thing)
    local results = qt:find(5, 5, 10, 10)
    assert.array_includes(thing, results)
  end)
end)