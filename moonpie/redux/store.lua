-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local logger = require "moonpie.logger"
local store = { }
local reducer_handler
local listeners = setmetatable({}, { __mode = "v" })
local state = {}

local function trigger_listeners()
  for _, v in ipairs(listeners) do
    v()
  end
end

function store.create_store(reducer, initial_state)
  assert(reducer, "Store requires a reducer function")
  reducer_handler = reducer
  state = initial_state
end

function store.dispatch(action, bypass_trigger)
  -- move to middleware?
  if type(action) == "function" then
    action(
      function(__action) store.dispatch(__action, true) end,
      store.get_state
    )
    trigger_listeners()
  else
    logger.debug("Store Dispatch: %s", action.type)
    state = reducer_handler(state, action)
    if not bypass_trigger then
      trigger_listeners()
    end
  end
end

function store.subscribe(listener)
  listeners[#listeners + 1] = listener
end

function store.get_state()
  return state
end

function store.get_listeners()
  return listeners
end

return store