-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"

local cache
local delay = 1
local last = 0
local function GetLatest()
  if cache == nil or love.timer.getTime() - last > delay then
    last = love.timer.getTime()
    local mem = collectgarbage("count")
    cache = Component.text({ text = "Memory: {{kbusage}} kb", kbusage = string.format("%.2f", mem) })
  end
  return cache
end

Component("memory_stats", function()
  return GetLatest()
end)