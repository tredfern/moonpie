-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.redux.store", function()
  local store = require "moonpie.redux.store"

  it("can have actions dispatched that are called into the reducer", function()
    local reducer = spy.new(function() end)
    local s = store:new(reducer)

    local action = {}
    s:dispatch(action)
    assert.spy(reducer).was.called_with(s.state, action)
  end)

  it("calls listeners when state has changed", function()
    local reducer = function() return {} end
    local listener = spy.new(function() end)
    local listener2 = spy.new(function() end)

    local s = store:new(reducer)
    s:subscribe(listener)
    s:subscribe(listener2)
    s:dispatch({})
    assert.spy(listener).was.called()
    assert.spy(listener2).was.called()
  end)

  it("listeners are weak values and allow garbage collection to occur", function()
    local s = store:new(function() end)
    local listener = function() end
    s:subscribe(listener)
    listener = nil
    assert.is_nil(listener) -- kind of annoying workaround for luacheck error
    collectgarbage()
    assert.equals(0, #s.listeners)
  end)

  it("provides access to the current version of state", function()
    local reduce_state = {}
    local initial_state = {}
    local s = store:new(function() return reduce_state end, initial_state)
    assert.equals(initial_state, s:get_state())
    s:dispatch({})
    assert.equals(reduce_state, s:get_state())
  end)

  it("passes the current state into the reducer", function()
    local state = {}
    local reducer = spy.new(function() return {} end)
    local s = store:new(reducer, state)
    local action = {}
    s:dispatch(action)
    assert.spy(reducer).was.called_with(action, state)
    state = s:get_state()
    s:dispatch(action)
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

    local s = store:new(reducer)
    s:dispatch(complex())
    assert.is_true(s:get_state().nice)
    assert.is_false(s:get_state().in_conversation)
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
    local s = store:new(reducer)
    s:subscribe(listener)
    s:dispatch(action_group())
    assert.equals(1, #listener.calls)
  end)
end)