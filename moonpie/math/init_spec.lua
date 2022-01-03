-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.math", function()
  local math_ext = require "moonpie.math"
  it("can clamp a value to a range", function()
    assert.equals(4, math_ext.clamp(4, 1, 10))
    assert.equals(1, math_ext.clamp(0, 1, 10))
    assert.equals(1, math_ext.clamp(0.9999, 1, 10))
    assert.equals(10, math_ext.clamp(10.000000001, 1, 10))
    assert.equals(10, math_ext.clamp(10, 1, 10))
    assert.equals(0, math_ext.clamp(-2, 0, 10))
  end)

  it("percent to decimal", function()
    assert.equals(0.75, math_ext.percentToNumber("75%"))
    assert.equals(0.33, math_ext.percentToNumber("33%"))
    assert.near(0.332525, math_ext.percentToNumber("33.2525%"), 0.0001)
    assert.equals(1, math_ext.percentToNumber("100%"))
  end)

  it("can return if string is percentile", function()
    assert.is_true(math_ext.isPercent("38.23%"))
    assert.is_true(math_ext.isPercent("633%"))
    assert.is_true(math_ext.isPercent("1%"))
    assert.is_false(math_ext.isPercent(1249))
    assert.is_false(math_ext.isPercent("1249"))
    assert.is_false(math_ext.isPercent("Foobar%%"))
  end)

  describe("between", function()
    it("returns true if value is between a range", function()
      local x = 4
      assert.is_true(math_ext.between(x, 1, 8))
    end)

    it("returns false if value is out of range", function()
      local y = 8
      assert.is_false(math_ext.between(y, 1, 5))
    end)

    it("returns true if the value is on the boundary", function()
      assert.is_true(math_ext.between(1, 1, 5))
      assert.is_true(math_ext.between(5, 1, 5))
    end)
  end)

  it("can flip a coin for easy binary choices", function()
    local got_heads, got_tails
    for _ = 1, 100 do
      got_heads = got_heads or math_ext.coinFlip()
      got_tails = got_tails or not math_ext.coinFlip()
    end
    assert.is_true(got_heads)
    assert.is_true(got_tails)
  end)

  it("can return the sign of the number", function()
    assert.equals(1, math_ext.sign(82))
    assert.equals(1, math_ext.sign(57))
    assert.equals(1, math_ext.sign(1))
    assert.equals(0, math_ext.sign(0))
    assert.equals(-1, math_ext.sign(-29))
    assert.equals(-1, math_ext.sign(-1))
    assert.equals(-1, math_ext.sign(-283))
  end)

  it("can return a random float value in range", function()
    for _ = 1,100 do
      assert.in_range(1.2, 2.7, math_ext.prandom(1.2, 2.7))
    end
  end)

  it("can floor multiple values", function()
    -- Useful for flooring functions that return multiple values
    local x, y, z = math_ext.floor(2.1, 2.9, 42.3)

    assert.equals(2, x)
    assert.equals(2, y)
    assert.equals(42, z)
  end)
end)
