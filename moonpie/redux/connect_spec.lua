-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.redux.connect", function()
  local connect = require "moonpie.redux.connect"
  local component = require "moonpie.ui.components.component"
  local store = require "moonpie.redux.store"
  local reducer = spy.new(function()
    return {
      a = "z",
      b = "y"
    }
  end)
  local render = spy.new(function() return {} end)
  local test_connect_component = component("test_connect", render)
  local connected = connect(
    test_connect_component,
    function(state) return { a = state.b } end
  )

  before_each(function()
    store.create_store(reducer)
  end)

  it("wraps the component creation mechanism", function()
    local props = { }
    local foo = connected(props)
    assert.equals("test_connect", foo.name)
    assert.spy(render).was.called_with(props)
  end)

  it("sets up a mapping function that calls update on component with new state", function()
    local c = connected()
    store.dispatch({})
    assert.equals("y", c.a)
  end)
end)