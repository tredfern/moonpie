-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.math.rectangle", function()
  local rectangle = require "moonpie.math.rectangle"

  it("can initialize x, y, width, and height", function()
    local r = rectangle.new(3, 4, 10, 20)
    assert.equals(3, r.x)
    assert.equals(4, r.y)
    assert.equals(10, r.width)
    assert.equals(20, r.height)
  end)

  it("can figure out its left/right, top/bottom", function()
    local r = rectangle.new(3, 4, 10, 20)
    assert.equals(3, r:left())
    assert.equals(4, r:top())
    assert.equals(13, r:right())
    assert.equals(24, r:bottom())
  end)

  describe("intersection checks", function()
    it("can detect if two rectangles intersect", function()
      local r = rectangle.new(3, 4, 15, 12)
      local r2 = rectangle.new(1, 2, 15, 10)
      assert.is_true(r:intersects(r2))
      assert.is_true(r2:intersects(r))
    end)

    it("can detect that two rectangles do not intersect", function()
      local r = rectangle.new(1, 1, 1, 1)
      local r2 = rectangle.new(10, 10, 1, 1)
      assert.is_false(r:intersects(r2))
      assert.is_false(r2:intersects(r))
    end)
  end)

  it("can return a rectangle that is the overlap of 2 other rectangles", function()
    local r = rectangle.new(0, 0, 10, 10)
    local r2 = rectangle.new(5, 5, 2, 15)
    local r3 = r:overlap(r2)
    assert.equals(5, r3:left())
    assert.equals(5, r3:top())
    assert.equals(7, r3:right())
    assert.equals(10, r3:bottom())
  end)
end)