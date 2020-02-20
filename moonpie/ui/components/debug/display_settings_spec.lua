-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Debug - DisplaySettings", function()
  local components = require "moonpie.ui.components"
  local mock_love = require "moonpie.test_helpers.mock_love"

  before_each(function()
    mock_love.mock(love.window, "getMode", spy.new(
      function()
        return 100, 100, {
          refreshrate = 45,
          vsync = true,
          fullscreen = true,
          fullscreentype = "exclusive"
      }
    end))
  end)

  it("retrieves the mode from love2d", function()
    local _ = components.display_settings()
    assert.spy(love.window.getMode).was.called()
  end)

  it("has the screen resolution", function()
    local ds = components.display_settings()
    local dim = ds:find_by_id("display_settings_resolution")
    assert.equals("Resolution: 100x100", dim.text)
  end)

  it("has the screen refresh rate", function()
    local ds = components.display_settings()
    local refresh = ds:find_by_id("display_settings_refresh_rate")
    assert.equals("Refresh Rate: 45hz", refresh.text)
  end)

  it("displays the vsync setting", function()
    local ds = components.display_settings()
    local vsync = ds:find_by_id("display_settings_vsync")
    assert.equals("Vsync: true", vsync.text)
  end)

  it("has fullscreen settings", function()
    local ds = components.display_settings()
    local fs = ds:find_by_id("display_settings_fullscreen")
    assert.equals("Fullscreen: true (exclusive)", fs.text)
  end)

  it("has a toggle for fullscreen settings to switch mode", function()
    local ds = components.display_settings()
    local btn = ds:find_by_id("toggle_fullscreen")
    assert.not_nil(btn)
    mock(love)
    btn:click()
    assert.spy(love.window.setMode).was.called()
    btn:click()
    assert.spy(love.window.setMode).was.called()
  end)
end)