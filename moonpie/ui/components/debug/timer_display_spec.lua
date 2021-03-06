-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Component - timer_display", function()
  local timer = require "moonpie.utility.timer"
  local components = require "moonpie.ui.components"

  local test_timer, display

  before_each(function()
    test_timer = timer:new("item")
    test_timer:start()
    test_timer:stop()
    display = components.timer_display({ timer = test_timer })
  end)

  it("displays the average time for the timer", function()
    local avg = display:findByID("timer_average")
    assert.equals("Avg: " .. string.format("%.4f", test_timer:average()), avg.text)
  end)

  it("displays the max time for the timer", function()
    local max = display:findByID("timer_max")
    assert.equals("Max: " .. string.format("%.4f", test_timer.max), max.text)
  end)

  it("displays the min time for the timer", function()
    local min = display:findByID("timer_min")
    assert.equals("Min: " .. string.format("%.4f", test_timer.min), min.text)
  end)

  it("display the name of the timer", function()
    local name = display:findByID("timer_name")
    assert.equals("Timer: item", name.text)
  end)

  it("displays unknown if timer not found", function()
    local no_timer = components.timer_display({})
    local name = no_timer:findByID("timer_name")
    assert.equals("Timer: NO TIMER", name.text)
  end)
end)
