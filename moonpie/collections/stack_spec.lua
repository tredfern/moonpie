-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Stack", function()
  local Stack = require "moonpie.collections.stack"

  it("Can push a value onto the stack", function()
    local s = Stack:new()
    s:push("A value")
    assert.equals("A value", s:top())
  end)

  it("Pushing multiple items changes the top item of the stack", function()
    local s = Stack:new()
    s:push("value 1")
    s:push("value 2")
    s:push("value 3")
    assert.equals("value 3", s:top())
  end)

  it("Can pop an item off of the top of the stack", function()
    local s = Stack:new()
    s:push("value 1")
    s:push("value 2")
    s:push("value 3")

    local pop = s:pop()
    assert.equals("value 3", pop)
    assert.equals("value 2", s:top())
  end)

  it("Can identify if it is empty", function()
    local s = Stack:new()
    assert.is_true(s:isempty())
    s:push("a value")
    assert.is_false(s:isempty())
    s:pop()
    assert.is_true(s:isempty())
  end)

  it("can be cleared out", function()
    local s = Stack:new()
    s:push("a value")
    s:push("b value")
    s:push("c value")
    s:clear()
    assert.is_true(s:isempty())
  end)
end)
