-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Callback", function()
  local callback = require "moonpie.callback"

  it("can register callbacks", function()
    local c = callback:new()
    local s = spy.new(function() end)
    c:add(spy_to_func(s))
    c:trigger()
    assert.spy(s).was.called()
  end)

  it("passes arguments to the callback", function()
    local c = callback:new()
    local s = spy.new(function() end)
    --spies are tables, to test functions we need to wrap
    c:add(spy_to_func(s))
    c:trigger(1, 2, 3, 4)
    assert.spy(s).was.called_with(1, 2, 3, 4)
  end)

  it("can register a table property for the callback", function()
    local c = callback:new()
    local t = {}
    t.cb = spy.new(function() end)
    c:add(t, "cb")
    c:trigger(1, 2, 3, 4)
    assert.spy(t.cb).was.called_with(t, 1, 2, 3, 4)
  end)

  it("can remove a callback", function()
    local c = callback:new()
    local s = spy.new(function() end)
    local f = spy_to_func(s)
    c:add(f)
    c:remove(f)
    c:trigger()
    assert.spy(s).was.not_called()
  end)
end)