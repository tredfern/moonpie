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
    assert.equals(0.75, math_ext.percent_to_number("75%"))
    assert.equals(0.33, math_ext.percent_to_number("33%"))
    assert.near(0.332525, math_ext.percent_to_number("33.2525%"), 0.0001)
    assert.equals(1, math_ext.percent_to_number("100%"))
  end)

  it("can return if string is percentile", function()
    assert.is_true(math_ext.is_percent("38.23%"))
    assert.is_true(math_ext.is_percent("633%"))
    assert.is_true(math_ext.is_percent("1%"))
    assert.is_false(math_ext.is_percent(1249))
    assert.is_false(math_ext.is_percent("1249"))
    assert.is_false(math_ext.is_percent("Foobar%%"))
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
      got_heads = got_heads or math_ext.coinflip()
      got_tails = got_tails or not math_ext.coinflip()
    end
    assert.is_true(got_heads)
    assert.is_true(got_tails)
  end)
end)
