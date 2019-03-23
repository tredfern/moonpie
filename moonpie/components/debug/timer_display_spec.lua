-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Component - timer_display", function()
  local timer = require "moonpie.utility.timer"
  local components = require "moonpie.components"

  local test_timer, display

  before_each(function()
    test_timer = timer:new("item")
    test_timer:start()
    test_timer:stop()
    display = components.timer_display({ timer = test_timer })
  end)

  it("displays the average time for the timer", function()
    local avg = display:find_by_id("timer_average")
    assert.equals("Avg: " .. test_timer:average(), avg.text)
  end)

  it("displays the max time for the timer", function()
    local max = display:find_by_id("timer_max")
    assert.equals("Max: " .. test_timer.max, max.text)
  end)

  it("displays the min time for the timer", function()
    local min = display:find_by_id("timer_min")
    assert.equals("Min: " .. test_timer.min, min.text)
  end)

  it("display the name of the timer", function()
    local name = display:find_by_id("timer_name")
    assert.equals("Timer: item", name.text)
  end)

  it("displays unknown if timer not found", function()
    local no_timer = components.timer_display({})
    local name = no_timer:find_by_id("timer_name")
    assert.equals("Timer: NO TIMER", name.text)
  end)
end)
