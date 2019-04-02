-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"

Component("timer_display", function(props)
  local t = props.timer or { name = "NO TIMER", average = function() return "--" end }
  return {
    { Component.text({ id = "timer_name", text = "Timer: {{name}}", name = t.name }) },
    { Component.text({ id = "timer_max", text = "Max: {{max}}", max = t.max }) },
    { Component.text({ id = "timer_min", text = "Min: {{min}}", min = t.min }) },
    { Component.text({ id = "timer_average", text = "Avg: {{average}}", average = t:average() }) }
  }
end)
