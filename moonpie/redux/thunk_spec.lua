-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.redux.thunk", function()
  local thunk = require "moonpie.redux.thunk"

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
end)