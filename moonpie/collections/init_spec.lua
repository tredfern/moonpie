-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Collections", function()
  local c = require "moonpie.collections"

  it("exposes the collections", function()
    assert.not_nil(c.deque)
    assert.not_nil(c.grid)
    assert.not_nil(c.list)
    assert.not_nil(c.priority_queue)
    assert.not_nil(c.queue)
    assert.not_nil(c.randomized_queue)
    assert.not_nil(c.stack)
    assert.not_nil(c.union_find)
  end)

  it("exposes the iterators", function()
    assert.not_nil(c.iterators.random)
    assert.not_nil(c.iterators.reverse)
  end)
end)
