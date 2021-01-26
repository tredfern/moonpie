-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"

Component("timer_display", function(props)
  local t = props.timer or { name = "NO TIMER", average = function() return 0 end }
  return {
    { Component.text({ id = "timer_name", text = "Timer: {{name}}", name = t.name }) },
    { Component.text({ id = "timer_max", text = "Max: {{max}}", max = string.format("%.4f", t.max or 0) }) },
    { Component.text({ id = "timer_min", text = "Min: {{min}}", min = string.format("%.4f", t.min or 0) }) },
    { Component.text({ id = "timer_average",
      text = "Avg: {{average}}",
      average = string.format("%.4f", t:average() or 0) }) }
  }
end)
