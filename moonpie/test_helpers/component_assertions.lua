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

local function contains_component(state, arguments)
  local find_name = arguments[1]
  local component = arguments[2]
  return #component:findAllByName(find_name) > 0
end

local function contains_component_with_id(state, arguments)
  local find_id = arguments[1]
  local component = arguments[2]
  return component:findByID(find_id) ~= nil
end


say:set("assertion.visible.positive", "Component %s is not visible.")
say:set("assertion.visible.negative", "Component %s is visible.")
assert:register("assertion", "visible", visible, "assertion.visible.positive", "assertion.visible.negative")

say:set("assertion.contains_component.positive", "Component %s does not contain %s.")
say:set("assertion.contains_component.negative", "Component %s contains %s.")
assert:register("assertion", "contains_component", contains_component, "assertion.contains_component.positive", "assertion.contains_component.negative")

say:set("assertion.contains_component_with_id.positive", "Component %s does not contain %s.")
say:set("assertion.contains_component_with_id.negative", "Component %s contains %s.")
assert:register("assertion", "contains_component_with_id", contains_component_with_id, "assertion.contains_component_with_id.positive", "assertion.contains_component_with_id.negative")