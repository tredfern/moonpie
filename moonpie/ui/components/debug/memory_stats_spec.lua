-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Component - memory_stats", function()
  -- Not easy to mock the garbagecollector... could make an api to wrap... but??
  local Components = require "moonpie.ui.components"
  local mock_love = require "moonpie.test_helpers.mock_love"

  teardown(function()
    mock_love.reset(love.timer, "getTime")
  end)

  it("exists", function()
    assert.not_nil(Components.memory_stats)
  end)

  it("returns the same text component if called multiple times close together", function()
    local t = Components.memory_stats()
    local t2 = Components.memory_stats()
    assert.equals(t, t2)
  end)

  it("returns a new text component if more than a second has passed", function()
    local t = Components.memory_stats()
    mock_love.mock(love.timer, "getTime", function() return 12000 end)
    local t2 = Components.memory_stats()
    assert.not_equal(t, t2)
  end)
end)