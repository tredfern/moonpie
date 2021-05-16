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
local actionListeners = {}
local state = {}
local logFilter = { }

local function triggerListeners(action, skipGlobal)
  if not skipGlobal then
    for _, v in pairs(listeners) do
      v()
    end
  end

  if type(action) == "table" and action.type then
    if actionListeners[action.type] then
      for _, v in pairs(actionListeners[action.type]) do
        v(action, store.invertedDispatch, store.getState)
      end
    end
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

function store.dispatch(action, bypassGlobalTrigger)
  if action == nil then return end

  -- move to middleware?
  if is_callable(action) then
    action(
      store.invertedDispatch,
      store.getState
    )
    triggerListeners(action)
  else
    -- validate action
    if action.validate and not action:validate(state) then
      return
    end

    if not tables.isEmpty(logFilter) and tables.any(logFilter, function(f) return f == action.type end) then
      logger.debug("Store Dispatch: %s", action.type)
    end
    state = reducerHandler(state, action)
    triggerListeners(action, bypassGlobalTrigger)
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

function store.subscribeTo(action, callback)
  -- Callbacks should drop if they aren't held on to
  actionListeners[action] = actionListeners[action] or setmetatable({}, { __mode = "v" })
  local cbs = actionListeners[action]
  cbs[#cbs + 1] = callback
end

function store.unsubscribe(callback)
  tables.removeItem(listeners, callback)
  for _, actions in pairs(actionListeners) do
    tables.removeItem(actions, callback)
  end
end

function store.clearSubscribers()
  listeners = {}
  actionListeners = {}
end

return store