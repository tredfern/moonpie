-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local callback = require "moonpie.callback"
local logger = require "moonpie.logger"

local event_system = {}
local events = {}

function event_system.subscribe(event_name, handler)
  if not events[event_name] then
    events[event_name] = callback:new()
  end
  events[event_name]:add(handler)
end
function event_system.unsubscribe(event_name, handler)
  events[event_name]:remove(handler)
end

function event_system.dispatch(event)
  logger.debug("Event System Dispatch: %s", event.type)
  if events[event.type] then
    events[event.type]:trigger(event)
  end
end

function event_system.clear()
  events = {}
end



return event_system