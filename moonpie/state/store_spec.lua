-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.state.store", function()
  local store = require "moonpie.state.store"

  it("ignores nil actions", function()
    local reducer = spy.new(function() end)
    store.createStore(reducer, {})
    assert.has_no_errors(function() store.dispatch(nil) end)
    assert.spy(reducer).was.not_called()
  end)

  it("can have actions dispatched that are called into the reducer", function()
    local reducer = spy.new(function() end)
    store.createStore(reducer)

    local action = {}
    local state = store.getState()
    store.dispatch(action)
    assert.spy(reducer).was.called_with(state, action)
  end)

  it("calls the reducer for initial state if non is provided", function()
    local start_state = {}
    local reducer = spy.new(function() return start_state end)
    store.createStore(reducer)
    assert.equals(start_state, store.getState())
  end)

  it("calls listeners when state has changed", function()
    local reducer = function() return {} end
    local listener = spy.new(function() end)
    local listener2 = spy.new(function() end)

    store.createStore(reducer)
    store.subscribe(listener)
    store.subscribe(listener2)
    store.dispatch({})
    assert.spy(listener).was.called()
    assert.spy(listener2).was.called()
  end)

  it("listeners are weak values and allow garbage collection to occur", function()
    store.createStore(function() end)
    local listener = function() end
    store.subscribe(listener)
    listener = nil
    assert.is_nil(listener) -- kind of annoying workaround for luacheck error
    collectgarbage()
    assert.equals(0, #store.getListeners())
  end)

  it("properly handles when the listener that is garbage collected still calls other listeners", function()
    store.createStore(function() end)
    local listener = function() end
    local listener2 = spy.new(function() end)
    store.subscribe(listener)
    store.subscribe(listener2)
    listener = nil
    assert.is_nil(listener) -- kind of annoying workaround for luacheck error
    collectgarbage()
    store.dispatch({})
    assert.spy(listener2).was.called()
  end)

  it("provides access to the current version of state", function()
    local reduce_state = {}
    local initial_state = {}
    store.createStore(function() return reduce_state end, initial_state)
    assert.equals(initial_state, store.getState())
    store.dispatch({})
    assert.equals(reduce_state, store.getState())
  end)

  it("passes the current state into the reducer", function()
    local state = {}
    local reducer = spy.new(function() return {} end)
    store.createStore(reducer, state)
    local action = {}
    store.dispatch(action)
    assert.spy(reducer).was.called_with(action, state)
    state = store.getState()
    store.dispatch(action)
    assert.spy(reducer).was.called_with(action, state)
  end)

  it("uses an empty table if initial_state is nil", function()
    store.createStore(function() end)
    assert.same({}, store.getState())
  end)

  it("functions can be dispatched that can hold multiple dispatches or logic", function()
    local complex = function()
      return function(dispatch, getState)
        dispatch{ type = "say-hi" }
        if getState().in_conversation then
          dispatch{ type = "say-goodbye" }
        end
      end
    end
    local reducer = function(state, action)
      if action.type == "say-hi" then
        return { in_conversation = true }
      end
      if action.type == "say-goodbye" then
        return { in_conversation = false, nice = true }
      end
      return state
    end

    store.createStore(reducer)
    store.dispatch(complex())
    assert.is_true(store.getState().nice)
    assert.is_false(store.getState().in_conversation)
  end)

  it("will call a table if callable", function()
    store.createStore(function() end)
    local called = false
    local complex = setmetatable({}, {
      __call = function(_, dispatch)
        dispatch({})
        called = true
      end
    })

    store.dispatch(complex)
    assert.is_true(called)
  end)

  it("dispatches only one listener call when dispatching a function", function()
    local action_group = function()
      return function(dispatch)
        dispatch({})
        dispatch({})
        dispatch({})
      end
    end

    local reducer = function() return {} end
    local listener = spy.new(function() end)
    store.createStore(reducer)
    store.subscribe(listener)
    store.dispatch(action_group())
    assert.equals(1, #listener.calls)
  end)


  describe("validating actions", function()
    local reducer = spy.new(function() return {} end)
    local state = {}

    before_each(function()
      store.createStore(reducer, state)
      reducer:clear() -- clear spy history
    end)

    it("will validate actions before passing to the reducer if validate method is provided", function()
      local an_action = { validate = spy.new(function() end) }

      store.dispatch(an_action)
      assert.spy(an_action.validate).was.called_with(an_action, store.getState())
    end)

    it("does not pass to the reducer if the action is invalid", function()
      local invalid_action = { validate = spy.new(function() return false end) }
      store.dispatch(invalid_action)
      assert.spy(reducer).was_not.called()
    end)

    it("calls the reducer if the action is valid", function()
      local valid_action = { validate = spy.new(function() return true end) }
      store.dispatch(valid_action)
      assert.spy(reducer).was.called_with(state, valid_action)
    end)
  end)

  it("can filter logging for certain action types", function()
    local logger = require "moonpie.logger"
    spy.on(logger, "debug")

    store.logFilterFor("ACTION_B")
    store.dispatch({ type = "ACTION_A" })
    store.dispatch({ type = "ACTION_B" })
    store.dispatch({ type = "ACTION_C" })

    assert.spy(logger.debug).was.called(1)

  end)

  it("can trigger callbacks for specific actions", function()
    local action = { type = "TRIGGER_CALLBACK" }
    local cb = spy.new(function() end)
    store.subscribeTo("TRIGGER_CALLBACK", cb)

    store.dispatch(action)
    assert.spy(cb).was.called_with(action, match.is_function(), match.is_function())
  end)

  it("can unsubscribe from callbacks and removes from any listener", function()
    local cb = spy.new(function() end)
    store.subscribeTo("TRIGGER_CALLBACK", cb)
    store.subscribe(cb)

    store.unsubscribe(cb)
    -- No listen events should occur
    local action = { type = "TRIGGER_CALLBACK" }
    store.dispatch(action)
    assert.spy(cb).was.not_called()
  end)

  it("can clear all subscribers", function()
    local cb = spy.new(function() end)
    store.subscribe(cb)
    store.clearSubscribers()

    store.dispatch({ type = "ACTION" })
    assert.spy(cb).was.not_called()
  end)
end)