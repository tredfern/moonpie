-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local assert = require("luassert")
local say = require("say")

local function visible(state, arguments)
  local component = arguments[1]
  return not component.hidden
end


say:set("assertion.visible.positive", "Component %s is not visible.")
say:set("assertion.visible.negative", "Component %s is visible.")
assert:register("assertion", "visible", visible, "assertion.visible.positive", "assertion.visible.negative")