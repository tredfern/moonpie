-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"
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
      Component.h3({ color = "white", text = "Profiler" }),
      Component.button_group({
        style = "align-right",
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
              report_output = profiler.report(nil, 15)
              output:update({ text = report_output })
            end
          }),
          Component.button({
            id = "profile_save",
            caption = "Save",
            click = function()
              love.filesystem.write("profile_report.txt", profiler.report())
            end
          }),
          Component.button({
            id = "profile_reset",
            caption = "Clear",
            click = function()
              profiler.reset()
            end
          })
        }
      })
    }, {
      output
    }
  }
end)
