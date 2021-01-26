-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Utility - Timer", function()
  local timer = require "moonpie.utility.timer"
  local mock_love = require "moonpie.test_helpers.mock_love"

  it("can track how long between an individual start and stop call", function()
    local t = timer:new()
    mock_love.mock(love.timer, "getTime", function() return 3 end)
    t:start()
    mock_love.mock(love.timer, "getTime", function() return 6 end)
    t:stop()
    assert.equals(3, t.last)
  end)

  it("can average the results that have occurred", function()
    local t = timer:new()
    mock_love.mock(love.timer, "getTime", function() return 3 end)
    t:start()
    mock_love.mock(love.timer, "getTime", function() return 6 end)
    t:stop()
    mock_love.mock(love.timer, "getTime", function() return 1 end)
    t:start()
    mock_love.mock(love.timer, "getTime", function() return 2 end)
    t:stop()
    assert.equals(2, t:average())
  end)

  it("can return the longest time that's occurred", function()
    local t = timer:new()
    mock_love.mock(love.timer, "getTime", function() return 0 end)
    t:start()
    mock_love.mock(love.timer, "getTime", function() return 2 end)
    t:stop()
    mock_love.mock(love.timer, "getTime", function() return 0 end)
    t:start()
    mock_love.mock(love.timer, "getTime", function() return 8 end)
    t:stop()
    assert.equals(8, t.max)
  end)

  it("can return the shortest non-zero time that's occurred", function()
    local t = timer:new()
    mock_love.mock(love.timer, "getTime", function() return 0 end)
    t:start()
    mock_love.mock(love.timer, "getTime", function() return 0 end)
    t:stop()
    mock_love.mock(love.timer, "getTime", function() return 0 end)
    t:start()
    mock_love.mock(love.timer, "getTime", function() return 8 end)
    t:stop()
    mock_love.mock(love.timer, "getTime", function() return 0 end)
    t:start()
    mock_love.mock(love.timer, "getTime", function() return 4 end)
    t:stop()
    assert.equals(4, t.min)
  end)

  it("can be named for reference", function()
    local t = timer:new("Watch This")
    assert.equals("Watch This", t.name)
  end)

  it("can be specified how many events to track for min/max/avg", function()
    local t = timer:new("Watch", 10)
    for x = 1, 20 do
      mock_love.mock(love.timer, "getTime", function() return 0 end)
      t:start()
      mock_love.mock(love.timer, "getTime", function() return x end)
      t:stop()
    end
    assert.equals(20, t.max)
    assert.equals(11, t.min)
    assert.equals(15.5, t:average())
  end)

end)
