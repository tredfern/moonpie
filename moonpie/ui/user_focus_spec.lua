-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("UserFocus", function()
  local UserFocus = require "moonpie.ui.user_focus"

  it("Tracks the focus of the current component", function()
    local c = {}
    UserFocus:setFocus(c)
    assert.equals(c, UserFocus:getFocus())
  end)

  it("can clear the focus", function()
    UserFocus:setFocus({})
    assert.not_nil(UserFocus:getFocus())
    UserFocus:clear()
    assert.is_nil(UserFocus:getFocus())
  end)
end)