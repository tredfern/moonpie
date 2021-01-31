-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("PriorityQueue", function()
  local PriorityQueue = require "moonpie.collections.priority_queue"

  it("initializes to empty", function()
    local pq = PriorityQueue:new()
    assert.is_true(pq:isEmpty())
  end)

  it("can insert an item into the queue, and track the size", function()
    local pq = PriorityQueue:new()
    assert.equals(0, pq:size())
    pq:insert(1)
    pq:insert(4)
    assert.equals(2, pq:size())
  end)

  it("knows the front of the queue, (defaults to largest value)", function()
    local pq = PriorityQueue:new()
    pq:insert(4)
    assert.equals(4, pq:front())
    pq:insert(8)
    assert.equals(8, pq:front())
    pq:insert(2)
    assert.equals(8, pq:front())
    pq:insert(12)
    assert.equals(12, pq:front())
    assert.array_matches({12, 8, 2, 4}, pq)
  end)

  it("can remove the top item and prepares the next item", function()
    local pq = PriorityQueue.maximum:new()
    pq:insert(5)
    pq:insert(2)
    pq:insert(8)
    pq:insert(3)
    assert.equals(8, pq:next())
    assert.array_matches({5, 2, 3}, pq)
    assert.equals(5, pq:next())
    assert.equals(3, pq:next())
    assert.equals(2, pq:next())
  end)

  it("can be set to be a minimum queue where it takes the lowest value item", function()
    local pq = PriorityQueue.minimum:new()
    pq:insert(7)
    pq:insert(2)
    pq:insert(5)
    pq:insert(1)
    assert.equals(1, pq:next())
    assert.equals(2, pq:next())
    assert.equals(5, pq:next())
    assert.equals(7, pq:next())
  end)

  it("works with three items added in this order", function()
    local pq = PriorityQueue.maximum:new()
    pq:insert(3)
    pq:insert(8)
    pq:insert(1)
    assert.equals(8, pq:next())
    assert.equals(3, pq:next())
    assert.equals(1, pq:next())
  end)

  it("can work with table entries as long as there is a definition for less than defined", function()
    local key = {}
    key.new = function(self, v)
      local k = v
      setmetatable(k, self)
      self.__lt = function(i, j) return i.value < j.value end
      return k
    end

    local k1 = key:new{value = 3}
    local k2 = key:new{value = 8}
    local k3 = key:new{value = 1}

    local pq = PriorityQueue.maximum:new()
    pq:insert(k1)
    pq:insert(k2)
    pq:insert(k3)
    assert.equals(k2, pq:next())
    assert.equals(k1, pq:next())
    assert.equals(k3, pq:next())
    assert.is_true(pq:isEmpty())
  end)
end)
