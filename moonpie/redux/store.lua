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

function store:dispatch(action)
  self.state = self.reducer(action, self.state)
  self:trigger_listeners()
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