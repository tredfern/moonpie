-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local logger = require "moonpie.logger"
local tables = require "moonpie.tables"
local is_callable = require "moonpie.utility.is_callable"

local store = { }
local reducerHandler
local listeners = setmetatable({}, { __mode = "v" })
local state = {}
local logFilter = { }

local function triggerListeners()
  for _, v in pairs(listeners) do
    v()
  end
end

function store.createStore(reducer, initial_state)
  assert(reducer, "Store requires a reducer function")
  reducerHandler = reducer
  state = initial_state or reducer(nil, { type = "___INITIALIZE_STORE___" }) or {}
end

function store.invertedDispatch(action)
  store.dispatch(action, true)
end

function store.dispatch(action, bypass_trigger)
  if action == nil then return end

  -- move to middleware?
  if is_callable(action) then
    action(
      store.invertedDispatch,
      store.getState
    )
    triggerListeners()
  else
    -- validate action
    if action.validate and not action:validate(state) then
      return
    end

    if not tables.isEmpty(logFilter) and tables.any(logFilter, function(f) return f == action.type end) then
      logger.debug("Store Dispatch: %s", action.type)
    end
    state = reducerHandler(state, action)
    if not bypass_trigger then
      triggerListeners()
    end
  end
end

function store.subscribe(listener)
  listeners[#listeners + 1] = listener
end

function store.getState()
  return state
end

function store.getListeners()
  return listeners
end

function store.logFilterFor(...)
  local items = tables.pack(...)
  for _, filter in ipairs(items) do
    table.insert(logFilter, filter)
  end
end

return store