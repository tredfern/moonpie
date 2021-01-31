-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.redux.connect", function()
  local component = require "moonpie.ui.components.component"
  local connect = require "moonpie.redux.connect"
  local store = require "moonpie.redux.store"

  local action_creator = function(props) return { type = "connected_action", payload = props } end

  local test_component = component("test_connect", function(props) return { a = props.a, b = props.b } end)
  local connected = connect(
    test_component,
    function(state) return { a = state.a, b = state.b } end
  )

  before_each(function()
    store.createStore(function(_, action)
      return {
        a = action.a,
        b = action.b,
        last_action = action
      }
    end, { a = "a", b = "b" })
  end)

  it("wraps the component creation mechanism", function()
    local props = { }
    local foo = connected(props)
    assert.equals("test_connect", foo.name)
  end)

  it("sets up a mapping function that calls update on component with new state", function()
    local c = connected()
    store.dispatch({ a = "v", b = "g" })
    assert.equals("v", c.a)
    assert.equals("g", c.b)
  end)

  it("can dispatch actions to the store", function()
    local c = connected({ click = function(self) self.dispatch(action_creator({ a = "foo" })) end })
    c:click()
    assert.equals("connected_action", store.getState().last_action.type)
  end)

  it("passes in initial state", function()
    local c = connected()
    assert.equals("a", c.a)
    assert.equals("b", c.b)
  end)
end)