-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Queues", function()
  local Queue = require "moonpie.collections.queue"
  it("can enqueue an item on to the queue", function()
    local q = Queue:new()
    q:enqueue("item")
    assert.equals("item", q:front())
  end)

  it("can dequeue an item from the queue", function()
    local q = Queue:new()
    q:enqueue("item")
    assert.equals("item", q:dequeue())
  end)

  it("removes the first item in to the queue", function()
    local q = Queue:new()
    q:enqueue("item 1")
    q:enqueue("item 2")
    q:enqueue("item 3")
    assert.equals("item 1", q:dequeue())
  end)

  it("Knows if it is empty", function()
    local q = Queue:new()
    assert.is_true(q:isEmpty())
    q:enqueue("item 1")
    assert.is_false(q:isEmpty())
    q:dequeue()
    assert.is_true(q:isEmpty())
  end)

  it("can clear out all queued items", function()
    local q = Queue:new()
    q:enqueue("item 1")
    q:enqueue("item 2")
    q:enqueue("item 3")
    q:clear()
    assert.is_true(q:isEmpty())
  end)

  it("knows the front item of the queue", function()
    local q = Queue:new()
    q:enqueue("item 1")
    q:enqueue("item 2")
    q:enqueue("item 3")
    assert.equals("item 1", q:front())
  end)

  it("can set the maximum size of the queue which automatically dequeues old values", function()
    local q = Queue:new{ maximum = 5 }
    q:enqueue(1)
    q:enqueue(2)
    q:enqueue(3)
    q:enqueue(4)
    q:enqueue(5)
    q:enqueue(6)

    assert.equals(5, #q)
    assert.equals(2, q:dequeue())
  end)
end)
