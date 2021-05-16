-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.test_helpers.matchers", function()
  it("can match a numeric range", function()
    local test = spy.new(function() end)

    test(3, -2, "6")
    
    assert.spy(test).was.called_with(match.in_range(2, 5), match.in_range(-1, -5), match.is_string())
    assert.spy(test).was.not_called_with(match.in_range(2, 5), match.is_number(), match.in_range(3, 9))
  end)
end)