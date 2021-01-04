-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.is_callable", function()
  local is_callable = require "moonpie.utility.is_callable"

  it("returns true if passed a function", function()
    assert.is_true(is_callable(function() end))
  end)

  it("returns false if passed a plain table", function()
    assert.is_false(is_callable({}))
  end)

  it("returns false if passed a table with a metatable without __call", function()
    local tbl  = setmetatable({}, {})
    assert.is_false(is_callable(tbl))
  end)

  it("returns false if passed a number or string", function()
    assert.is_false(is_callable(304))
    assert.is_false(is_callable("Hello!"))
  end)

  it("returns true if passed a table with a metatable that implements __call", function()
    local callable_table = setmetatable({}, {
      __call = function() end
    })

    assert.is_true(is_callable(callable_table))
    assert.has_no_errors(function() callable_table() end)
  end)
end)