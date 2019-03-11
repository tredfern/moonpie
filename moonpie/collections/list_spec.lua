-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("List", function()
  local list = require "moonpie.collections.list"

  it("should operate like a normal lua set", function()
    local b = list:new()
    b:add(1)
    b:add(2)
    assert.equals(2, #b)
    assert.equals(1, b[1])
    assert.equals(2, b[2])
  end)

  it("can add and remove items", function()
    local b = list:new()
    b:add("foo")
    b:add("bar")
    b:remove("bar")
    assert.array_matches({"foo"}, b)
  end)

  it("can add many items at a time", function()
    local b = list:new()
    b:add(1, 2, 3, 4)
    assert.array_matches({1, 2, 3, 4 }, b)
  end)

  it("can find items in the list", function()
    local b = list:new()
    b:add("foo")
    b:add("goo")
    b:add("soo")
    assert.is_true(b:contains("goo"))
    assert.is_false(b:contains("hoo"))
  end)

  it("can find the index of the first item that matches", function()
    local b = list:new()
    b:add("bar")
    b:add("car")
    b:add("dar")
    b:add("ear")
    assert.equals(3, b:index_of("dar"))
  end)

  it("can be initialized with a list of items", function()
    local b = list:new({"one", "two", "three"})
    assert.is_true(b:contains("one"))
    assert.equals(3, #b)
  end)

  it("can get the first item from the list", function()
    local b = list:new({"one", "two", "three"})
    assert.equals("one", b:first())
  end)

  it("can get the last item from the list", function()
    local b = list:new({"one", "two", "three"})
    assert.equals("three", b:last())
  end)

  it("can have a filter for first item that returns the first item that matches the filter", function()
    local b = list:new({2, 4, 6, 8 })
    local found = b:find(function(c) return c % 2 == 0 end)
    assert.equals(2, found)
  end)

  it("it returns nil on a search if it cannot find any item", function()
    local b = list:new({"one", "two", "three"})
    local none = b:find(function(c) return c == "four" end)
    assert.equals(nil, none)
  end)

  it("can have a filter for last item that returns the last item that matches the filter", function()
    local b = list:new({2, 4, 6, 8})
    local found = b:find_last(function(c) return c % 2 == 0 end)
    assert.equals(8, found)
  end)

  it("it returns nil on a search if it cannot find any item", function()
    local b = list:new({"one", "two", "three"})
    local none = b:find_last(function(c) return c == "four" end)
    assert.equals(nil, none)
  end)

  it("can get a filtered list matching a function", function()
    local b = list:new({1,2,3,4,5,6,7,8})
    local even = function(c) return c % 2 == 0 end
    local filtered = b:where(even)
    assert.array_matches({2,4,6,8}, filtered)
  end)

  it("if you try to remove nil it doesn't do anything", function()
    local b = list:new{1,2,3,4,5}
    b:remove(nil)
    assert.array_matches({1,2,3,4,5}, b)
  end)

  it("can return the first(n) elements from the list", function()
    local b = list:new{1,2,3,4,5}
    local l = b:first(3)
    assert.array_matches({1,2,3}, l)
  end)

  it("can return the last(n) elements from the list", function()
    local b = list:new{1, 2, 3, 4, 5}
    local l = b:last(3)
    assert.array_matches({3, 4, 5}, l)
  end)

  it("can return a slice of the list", function()
    local b = list:new{1, 2, 3, 4, 5}
    local l = b:slice(2, 3)
    assert.array_matches({2, 3, 4}, l)
  end)

  it("can be cleared out", function()
    local l = list:new{1, 2, 3, 4, 5}
    assert.is_false(l:isempty())
    l:clear()
    assert.is_true(l:isempty())
  end)

  it("is empty with nothing added", function()
    local l = list:new()
    assert.is_true(l:isempty())
    l:add("foo")
    assert.is_false(l:isempty())
  end)
end)
