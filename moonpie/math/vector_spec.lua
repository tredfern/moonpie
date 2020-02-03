-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.math.vector", function()
  local vector = require "moonpie.math.vector"

  describe("creating", function()
    it("can initialize a vector", function()
      local v = vector.new(1, 2)
      assert.equals(1, v.x)
      assert.equals(2, v.y)
    end)

    it("can create a vector from angle and magnitude", function()
      local v = vector.from_angle(math.rad(15), 4)
      assert.near(3.86, v.x, 0.01)
      assert.near(1.03, v.y, 0.01)
    end)
  end)

  describe("math operations", function()
    it("can multiply the vector", function()
      local v = vector.new(1, 2)
      v:multiply(2)
      assert.equals(2, v.x)
      assert.equals(4, v.y)
    end)

    it("can divide a vector", function()
      local v = vector.new(2, 4)
      v:divide(2)
      assert.equals(1, v.x)
      assert.equals(2, v.y)
    end)

    it("can add a vector", function()
      local v1 = vector.new(1, 2)
      local v2 = vector.new(3, 4)
      v1:add(v2)
      assert.equals(4, v1.x)
      assert.equals(6, v1.y)
    end)

    it("can calculate the dot product", function()
      local v = vector.new(3, 4)
      local v2 = vector.new(4, 3)
      assert.equals(24, v:dot(v2))
    end)
  end)


  it("can get the magnitude of vector", function()
    local v = vector.new(3, 3)
    local mag = v:magnitude()
    assert.equals(math.sqrt(18), mag)
  end)

  it("can get the magnitude squared for performance", function()
    local v = vector.new(3, 3)
    assert.equals(18, v:magnitude_squared())
  end)

  it("can invert the vector", function()
    local v = vector.new(1, 2)
    v:invert()
    assert.equals(-1, v.x)
    assert.equals(-2, v.y)
  end)

  it("can normalize the vector", function()
    local v = vector.new(5, 10)
    v:normalize()
    assert.is_true(v.x < 1)
    assert.is_true(v.y < 1)
    assert.near(1, v:magnitude(), 0.001)
  end)

  it("can return the angle of the vector", function()
    local v = vector.from_angle(math.rad(25), 1)
    assert.near(25, math.deg(v:get_angle()), 0.0001)
  end)

  it("can unpack the vector", function()
    local v = vector.new(4, 5)
    local x, y = v:unpack()
    assert.equals(4, x)
    assert.equals(5, y)
  end)
end)