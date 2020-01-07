-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local UserFocus = {}

function UserFocus:set_focus(component)
  self.focus_component = component
end

function UserFocus:get_focus()
  return self.focus_component
end

function UserFocus:clear()
  self.focus_component = nil
end

return UserFocus