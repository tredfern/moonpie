-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local callback = require "moonpie.callback"

local event_system = {}
local events = {}

function event_system.subscribe(event_name, handler)
  if not events[event_name] then
    events[event_name] = callback:new()
  end
  events[event_name]:add(handler)
end

function event_system.dispatch(event)
  if events[event.type] then
    events[event.type]:trigger(event)
  end
end



return event_system