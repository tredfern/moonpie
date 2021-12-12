-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.state.store"
local tables = require "moonpie.tables"

local mock_reducer = function(state, action)
  if action.type == "mock_store_update_state" then
    state = action.payload
  end

  return tables.assign({}, state, {
    actions = tables.concatArray(state.actions, { action })
  })
end

function store.get_action_groups()
  local actions = store.getState().actions or {}
  return tables.groupBy(actions, function(a) return a.type end)
end

function store.get_actions(type)
  local groups = store.get_action_groups()
  return groups[type]
end

function store.simulate_change(new_state)
  store.dispatch{ type = "mock_store_update_state", payload = new_state}
end

return function(stub_state)
  stub_state = stub_state or {}
  store.clearSubscribers()
  store.createStore(mock_reducer, stub_state)
  return store
end