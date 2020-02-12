-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.math.dice", function()
  local dice = require "moonpie.math.dice"

  it("can roll some dice", function()
    for _=1,100 do
      assert.in_range(1, 3, dice.d3())
      assert.in_range(1, 4, dice.d4())
      assert.in_range(1, 6, dice.d6())
      assert.in_range(1, 8, dice.d8())
      assert.in_range(1, 10, dice.d10())
      assert.in_range(1, 12, dice.d12())
      assert.in_range(1, 20, dice.d20())
      assert.in_range(1, 100, dice.d100())
    end
  end)

  it("can roll multiple dice together", function()
    local cup = dice.cup(dice.d6, dice.d6, dice.d3, dice.d20)
    for _=1,100 do
      assert.in_range(4, 35, cup())
    end
  end)

  it("an make a cup with a modifier", function()
    local cup = dice.cup(dice.d6, dice.d6)
    cup.modifier = 2
    for _=1,100 do
      assert.in_range(4, 14, cup())
    end
  end)

  it("Can turn dice into names", function()
    assert.equals("d4", tostring(dice.d4))
    assert.equals("d6", tostring(dice.d6))
    assert.equals("d8", tostring(dice.d8))
    assert.equals("d10", tostring(dice.d10))
    assert.equals("d12", tostring(dice.d12))
    assert.equals("d20", tostring(dice.d20))
    assert.equals("d100", tostring(dice.d100))
  end)

  it("can parse a string of dice into a cup", function()
    local cup = dice.parse("2d6+2")
    local cup2 = dice.parse("2d6-2")
    local cup3 = dice.parse("2d6+2d8+2")
    for _=1, 100 do
      assert.in_range(4, 14, cup())
      assert.in_range(0, 10, cup2())
      assert.in_range(6, 30, cup3())
    end
  end)
end)