-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.redux.bind", function()
  local bind = require "moonpie.redux.bind"
  local Components = require "moonpie.ui.components"
  local store = require "moonpie.redux.store"

  before_each(function()
    store.createStore(function(_, action)
      return {
        a = action.a,
        b = action.b,
      }
    end, { a = "a", b = "b" })
  end)

  it("can create a custom connection for a component to track a state value", function()
    local t = bind(Components.text { text = "foo" }, function(component, state)
      component:update { text = state.a }
    end)

    store.dispatch({ a = "new-value" })
    assert.equals("new-value", t.text)
  end)
end)