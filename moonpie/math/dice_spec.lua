-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.math.dice", function()
  local dice = require "moonpie.math.dice"

  it("can roll a d6 die", function()
    for _=1,100 do
      local result = dice.d6()
      assert.in_range(1, 6, result)
    end
  end)
end)