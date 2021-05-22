-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.test_helpers.custom_assertions", function()
  it("can just fail", function()
    assert.is_not.fail()
  end)

  it("can detect if a callable table or function is in a value", function()
    assert.callable(function() end)
    local ct = setmetatable({}, { __call = function() end })
    assert.callable(ct)
    assert.not_callable({})
    assert.not_callable(31832)
  end)

end)