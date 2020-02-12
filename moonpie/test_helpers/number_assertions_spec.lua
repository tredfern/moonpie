-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.test_helpers.number_assertions", function()
  it("can check if a number is greater than", function()
    assert.greater_than(5, 6)
    assert.not_greater_than(6, 5)
  end)

  it("can check if a number is less than", function()
    assert.less_than(4, 3)
    assert.not_less_than(3, 4)
  end)

  it("can check if a number is in a range", function()
    assert.in_range(3, 7, 4)
    assert.in_range(3, 7, 3)
    assert.in_range(3, 7, 7)
    assert.not_in_range(3, 7, 2)
    assert.not_in_range(3, 7, 9)
  end)
end)