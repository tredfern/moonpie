-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.swap_function", function()
  local swapFunction = require "moonpie.utility.swap_function"

  it("can replace a function in a table", function()
    local orig = function() end
    local new = spy.new(function() end)
    local t = {
      f = orig
    }

    swapFunction(t, "f", new)
    t.f(1)

    assert.spy(new).was.called_with(1)
    t:f()
    assert.spy(new).was.called_with(t)

    t.f:revert()
    assert.equals(orig, t.f)
  end)
end)