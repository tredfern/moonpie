-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local callback = require "moonpie.callback"

local event_system = {}
local events = {}

function event_system.register(event_name)
  events[event_name] = callback:new()
end

function event_system.is_registered(event_name)
  return events[event_name] ~= nil
end

function event_system.subscribe(event_name, handler)
  events[event_name]:add(handler)
end

function event_system.dispatch(event)
  events[event.type]:trigger(event)
end



return event_system