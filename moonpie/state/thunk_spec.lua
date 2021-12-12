-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.state.thunk", function()
  local thunk = require "moonpie.state.thunk"

  it("takes a type and function for the thunk", function()
    local f = function() end
    local t = thunk("CREATE_THE_UNIVERSE", f)
    assert.equals("CREATE_THE_UNIVERSE", t.type)
    assert.equals(f, t.handler)
  end)

  it("will call the handler when calling the thunk", function()
    local f = spy.new(function() end)
    local t = thunk("VERIFY_CALL", f)
    local dispatch, getState = {}, {}
    t(dispatch, getState)
    assert.spy(f).was.called_with(dispatch, getState)
  end)

  it("can be given a validator to determine whether to process the handler", function()
    local validate = spy.new(function() return false end)
    local handle = spy.new(function() end)
    local t = thunk("WITH_VALIDATOR", handle, validate)
    local dispatch, getState = {}, {}
    t(dispatch, getState)
    assert.spy(validate).was.called_with(getState)
    assert.spy(handle).was.not_called()
  end)
end)