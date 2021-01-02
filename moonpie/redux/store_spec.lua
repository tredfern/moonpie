-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.redux.store", function()
  local store = require "moonpie.redux.store"

  it("ignores nil actions", function()
    local reducer = spy.new(function() end)
    store.create_store(reducer)
    assert.has_no_errors(function() store.dispatch(nil) end)
    assert.spy(reducer).was.not_called()
  end)

  it("can have actions dispatched that are called into the reducer", function()
    local reducer = spy.new(function() end)
    store.create_store(reducer)

    local action = {}
    local state = store.get_state()
    store.dispatch(action)
    assert.spy(reducer).was.called_with(state, action)
  end)

  it("calls listeners when state has changed", function()
    local reducer = function() return {} end
    local listener = spy.new(function() end)
    local listener2 = spy.new(function() end)

    store.create_store(reducer)
    store.subscribe(listener)
    store.subscribe(listener2)
    store.dispatch({})
    assert.spy(listener).was.called()
    assert.spy(listener2).was.called()
  end)

  it("listeners are weak values and allow garbage collection to occur", function()
    store.create_store(function() end)
    local listener = function() end
    store.subscribe(listener)
    listener = nil
    assert.is_nil(listener) -- kind of annoying workaround for luacheck error
    collectgarbage()
    assert.equals(0, #store.get_listeners())
  end)

  it("provides access to the current version of state", function()
    local reduce_state = {}
    local initial_state = {}
    store.create_store(function() return reduce_state end, initial_state)
    assert.equals(initial_state, store.get_state())
    store.dispatch({})
    assert.equals(reduce_state, store.get_state())
  end)

  it("passes the current state into the reducer", function()
    local state = {}
    local reducer = spy.new(function() return {} end)
    store.create_store(reducer, state)
    local action = {}
    store.dispatch(action)
    assert.spy(reducer).was.called_with(action, state)
    state = store.get_state()
    store.dispatch(action)
    assert.spy(reducer).was.called_with(action, state)
  end)

  it("functions can be dispatched that can hold multiple dispatches or logic", function()
    local complex = function()
      return function(dispatch, get_state)
        dispatch{ type = "say-hi" }
        if get_state().in_conversation then
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

    store.create_store(reducer)
    store.dispatch(complex())
    assert.is_true(store.get_state().nice)
    assert.is_false(store.get_state().in_conversation)
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
    store.create_store(reducer)
    store.subscribe(listener)
    store.dispatch(action_group())
    assert.equals(1, #listener.calls)
  end)


  describe("validating actions", function()
    local reducer = spy.new(function() return {} end)
    local state = {}

    before_each(function()
      store.create_store(reducer, state)
      reducer:clear() -- clear spy history
    end)

    it("will validate actions before passing to the reducer if validate method is provided", function()
      local an_action = { validate = spy.new(function() end) }

      store.dispatch(an_action)
      assert.spy(an_action.validate).was.called_with(an_action, store.get_state())
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
end)