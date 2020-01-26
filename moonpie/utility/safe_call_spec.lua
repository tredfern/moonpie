-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("SafeCall", function()
  local safecall = require "moonpie.utility.safe_call"

  it("calls a function with parameters if it exists", function()
    local f = spy.new(function() end)
    safecall(f, "1", "2", 3, 4)
    assert.spy(f).was.called.with("1", "2", 3, 4)
  end)

  it("returns nil if the function is nil", function()
    assert.has_no.errors(function() safecall(nil, 1, 2, 3, 4) end)
  end)

  it("works with calling tables", function()
    local f = {
      call = spy.new(function() end)
    }
    safecall(f.call, f)
    assert.spy(f.call).was.called_with(f)
  end)
end)