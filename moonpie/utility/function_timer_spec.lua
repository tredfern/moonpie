-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Utility - Function Timer", function()
  local sleep = require "moonpie.utility.sleep"
  local function_timer = require "moonpie.utility.function_timer"

  it("still calls an existing function", function()
    local f = function(arg1, arg2, arg3) return arg1 + arg2 + arg3 end
    local timed = function_timer:new(f)
    assert.equals(6, timed(1, 2, 3))
  end)

  it("can return multiple arguments if the function does so", function()
    local f = function() return 1, 2, 3, 4, 5 end
    local timed = function_timer:new(f)
    local r1, r2, r3, r4, r5 = timed()
    assert.equals(1, r1)
    assert.equals(2, r2)
    assert.equals(3, r3)
    assert.equals(4, r4)
    assert.equals(5, r5)
  end)

  it("tracks the results of timed calls", function()
    local f = function() sleep(0.1) end
    local timed = function_timer:new(f)
    timed()
    assert.not_equal(0, timed.timer.max)
    assert.not_equals(0, timed.timer.min)
    assert.near(0.1, timed.timer.last, 0.01)
  end)

end)
