-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("UserFocus", function()
  local UserFocus = require "moonpie.ui.user_focus"

  it("Tracks the focus of the current component", function()
    local c = {}
    UserFocus:set_focus(c)
    assert.equals(c, UserFocus:get_focus())
  end)

  it("can clear the focus", function()
    UserFocus:set_focus({})
    assert.not_nil(UserFocus:get_focus())
    UserFocus:clear()
    assert.is_nil(UserFocus:get_focus())
  end)
end)