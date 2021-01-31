-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Profiler Component", function()
  local components = require "moonpie.ui.components"
  local profile_report = components.profile_report
  local profiler = require "moonpie.ext.profile"

  it("can start the profiler", function()
    profiler.hookall = spy.new(function() end)
    profiler.start = spy.new(function() end)

    local comp = profile_report()
    local btn = comp:findByID("profile_start")
    btn:click()
    assert.spy(profiler.hookall).was.called.with("Lua")
    assert.spy(profiler.start).was.called()
  end)

  it("can stop the profiler", function()
    profiler.stop = spy.new(function() end)
    local comp = profile_report()
    local btn = comp:findByID("profile_stop")
    btn:click()
    assert.spy(profiler.stop).was.called()
  end)

  it("can generate a report of profiler information", function()
    profiler.report = spy.new(function() return "REPORT" end)
    local comp = profile_report()
    local refresh = comp:findByID("profile_refresh")
    local output = comp:findByID("profile_output")
    refresh:click()
    assert.equals("REPORT", output.text)
  end)

  it("can save the full report to a file", function()
    local mock_love = require "moonpie.test_helpers.mock_love"
    mock_love.mock(love.filesystem, "write", spy.new(function() end))
    profiler.report = spy.new(function() return "REPORT" end)
    local comp = profile_report()
    local save = comp:findByID("profile_save")
    save:click()
    assert.spy(love.filesystem.write).was.called.with("profile_report.txt", "REPORT")
  end)

  it("can reset the profiler", function()
    profiler.reset = spy.new(function() end)
    local comp = profile_report()
    local reset = comp:findByID("profile_reset")
    reset:click()
    assert.spy(profiler.reset).was.called()
  end)
end)
