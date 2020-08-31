-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.test_helpers.mock_store", function()
  local mock_store = require "moonpie.test_helpers.mock_store"

  it("mocks out the reducers and does not call them", function()
    local s = mock_store()
    s:dispatch({})
  end)

  it("can be stubbed out to a starting state", function()
    local state = {1, 2,3, 4}
    local s = mock_store(state)
    assert.equals(state, s.get_state())
  end)

  it("returns what actions were dispatched to the store", function()
    local store = mock_store{}
    store.dispatch { type = "test" }
    store.dispatch { type = "test" }
    store.dispatch { type = "test2" }
    assert.equals(2, #store.get_actions("test"))
    assert.equals(1, #store.get_actions("test2"))
  end)

  it("can simulate a state change that triggers listen event", function()
    local store = mock_store{}
    local listener = spy.new(function() end)
    store.subscribe(listener)
    
    store.simulate_change({ new_state = true })
    assert.is_true(store.get_state().new_state)
    assert.spy(listener).was.called()
  end)
end)