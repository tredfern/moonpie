-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Randomized Queue", function()
  local RandomizedQueue = require "moonpie.collections.randomized_queue"
  local MockRandom = require "moonpie.test_helpers.mock_random"

  it("Knows when it is empty", function()
    local r = RandomizedQueue:new()
    assert.is_true(r:isEmpty())
  end)

  it("can queue items up", function()
    local r = RandomizedQueue:new()
    r:enqueue("item 1")
    r:enqueue("item 2")
    assert.equals(2, #r)
  end)

  it("can sample a random item from the queue but does not remove", function()
    MockRandom.setreturnvalues{2, 1, 2, 3}

    local r = RandomizedQueue:new()
    r:enqueue("item 1")
    r:enqueue("item 2")
    r:enqueue("item 3")

    assert.equals("item 2", r:sample())
    assert.equals("item 1", r:sample())
    assert.equals("item 2", r:sample())
    assert.equals("item 3", r:sample())
  end)

  it("dequeue removes a random item from the queue", function()
    MockRandom.setreturnvalues{2, 2, 1}

    local r = RandomizedQueue:new()
    r:enqueue("item 1")
    r:enqueue("item 2")
    r:enqueue("item 3")

    assert.is_false(r:isEmpty())
    assert.equals("item 2", r:dequeue())
    assert.equals("item 3", r:dequeue())
    assert.equals("item 1", r:dequeue())
    assert.is_true(r:isEmpty())
  end)

  it("can be initialized with a table of values", function()
    local r = RandomizedQueue:new{1, 2, 3, 4}
    assert.is_false(r:isEmpty())
    assert.equals(4, #r)
    assert.equals(1, r[1])
    assert.equals(3, r[3])
  end)
end)
