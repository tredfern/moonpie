-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Deque", function()
  local Deque = require "moonpie.collections.deque"
  it("Knows when it is empty", function()
    local d = Deque:new()
    assert.is_true(d:isempty())
  end)

  it("can add and pop item to the left side of the queue", function()
    local d = Deque:new()
    d:pushfront("item 1")
    d:pushfront("item 2")
    assert.is_false(d:isempty())
    assert.equals("item 2", d:popfront())
    assert.equals("item 1", d:popfront())
    assert.is_true(d:isempty())
  end)

  it("can push items to the end of the queue", function()
    local d = Deque:new()
    d:pushback("item 1")
    d:pushback("item 2")
    assert.is_false(d:isempty())
    assert.equals("item 2", d:popback())
    assert.equals("item 1", d:popback())
    assert.is_true(d:isempty())
  end)

  it("can push to the back and remove from the front", function()
    local d = Deque:new()
    d:pushback("item 1")
    d:pushback("item 2")
    d:pushback("item 3")
    assert.equals("item 1", d:popfront())
    assert.equals("item 2", d:popfront())
  end)
end)
