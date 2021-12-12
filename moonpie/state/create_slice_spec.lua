-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.state.createSlice", function()
  local store = require "moonpie.state.store"
  local createSlice = require "moonpie.state.create_slice"

  it("takes a table and creates a function for the reducer", function()
    local test = {
      action_1 = function(state, action) return { v = state.v + action.payload } end,
      action_2 = function(state, action) return { v = state.v - action.payload } end
    }

    store.createStore(createSlice(test), { v = 0 })

    store.dispatch({ type = "action_1", payload = 1 })
    local s = store.getState()
    assert.equals(1, s.v)

    store.dispatch { type = "action_2", payload = -2 }
    s = store.getState()
    assert.equals(3, s.v)
  end)

  it("returns the state back if the action is not in the list", function()
    local state = {}
    local test = {}

    store.createStore(createSlice(test), state)
    store.dispatch({ type = "some_action" })
    assert.equals(state, store.getState())
  end)

  it("can specify an initial state and the store is configured with that state", function()
    local slice = createSlice {
      initialState = function()
        return {
          v = 1, x = 2, b = "hello"
        }
      end
    }

    store.createStore(slice)
    local state = store.getState()
    assert.equals(1, state.v)
    assert.equals(2, state.x)
    assert.equals("hello", state.b)
  end)

  it("works with combine reducers to specify complex initial states", function()
    local combine_reducers = require "moonpie.state.combine_reducers"
    local slice1 = createSlice {
      initialState = function() return { v = 3 } end
    }
    local slice2 = createSlice {
      initialState = function() return { v = 6 } end
    }

    store.createStore(combine_reducers {
      slice1 = slice1,
      slice2 = slice2
    })
    local state = store.getState()
    assert.equals(3, state.slice1.v)
    assert.equals(6, state.slice2.v)
  end)

  it("uses an empty table for initial state if nothing is specified for state", function()
    local combineReducers = require "moonpie.state.combine_reducers"
    local slice = createSlice {}
    store.createStore(combineReducers { slice = slice })
    assert.same({}, store.getState().slice)
  end)
end)