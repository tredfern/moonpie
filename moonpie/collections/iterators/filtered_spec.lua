-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.collections.iterators.filtered", function()
  local filtered = require "moonpie.collections.iterators.filtered"

  it("returns the next result that matches the filter", function()
    local values = {
      1, 2, 3, 4, 5, 6, 7, 8
    }
    local evens = function(x) return x % 2 == 0 end
    local f = filtered(values, evens)
    assert.equals(2, f())
    assert.equals(4, f())
    assert.equals(6, f())
    assert.equals(8, f())
    assert.equals(nil, f())
  end)

  it("works as a loop iterator", function()
    local values = { 1, 2, 3, 4, 5, 6}
    local evens = function(x) return x % 2 ==0 end
    local count = 0
    for _ in filtered(values, evens) do
      count = count + 1
    end
    assert.equals(3, count)
  end)
end)