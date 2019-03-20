-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.components.component"
local profiler = require "moonpie.ext.profile"
local logger = require "moonpie.logger"
local report_output

local function start_profiler()
  logger.debug("Starting Profiler")
  profiler.hookall("Lua")
  profiler.start()
end

local function stop_profiler()
  logger.debug("Stopping Profiler")
  profiler.stop()
end

Component("profile_report", function()
  local output = Component.text({
    id = "profile_output",
    text = report_output
  })

  return {
    {
      Component.h3({ text = "Profiler" }),
      Component.button_group({
        align = "right",
        buttons = {
          Component.button({
            id = "profile_start",
            caption = "Start",
            click = start_profiler
          }),
          Component.button({
            id = "profile_stop",
            caption = "Stop",
            click = stop_profiler
          }),
          Component.button({
            id = "profile_refresh",
            caption = "Refresh",
            click = function()
              report_output = profiler.report()
              output:update({ text = report_output })
            end
          })
        }
      })
    }, {
      output
    }
  }
end)
