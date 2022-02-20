-- Copyright (c) 2022 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.match", function()
  local match = require "moonpie.utility.match"

  it("takes a value and returns the matching value from the table", function()
    local value = "B"
    local out = match(value, {
      A = 1,
      B = 2,
      C = 3,
    })

    assert.equals(2, out)
  end)

  it("if the matching value is a function it returns the result from the function", function()
    local value = "C"
    local out = match(value, {
      A = function() return 1 end,
      B = function() return 2 end,
      C = function() return 3 end,
    })

    assert.equals(3, out)
  end)

  it("can have a default result if nothing matches", function()
    local out = match("D", {
      A = 1, B = 2, C = 3, _ = 10
    })

    assert.equals(10, out)
  end)
end)