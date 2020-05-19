-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local store = {}

function store:constructor(reducer, initial_state)
  assert(reducer, "Store requires a reducer function")
  self.reducer = reducer
  self.listeners = setmetatable({}, { __mode = "v" })
  self.state = initial_state
end

function store:dispatch(action, bypass_trigger)
  -- move to middleware?
  if type(action) == "function" then
    action(
      function(__action) self:dispatch(__action, true) end,
      function() return self:get_state() end
    )
    self:trigger_listeners()
  else
    self.state = self.reducer(self.state, action)
    if not bypass_trigger then
      self:trigger_listeners()
    end
  end
end

function store:subscribe(listener)
  self.listeners[#self.listeners + 1] = listener
end

function store:trigger_listeners()
  for _, v in ipairs(self.listeners) do
    v()
  end
end

function store:get_state()
  return self.state
end

return class(store)