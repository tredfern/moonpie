-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local assert = require("luassert")
local say = require("say")

local function array_matches(state, arguments)
  local expected = arguments[1]
  local tested = arguments[2]
  local matched = true

  if not type(expected) == "table" and not type(tested) == "table" then
    return false
  end

  for i, v in ipairs(expected) do
    matched = matched and v == tested[i]  
  end

  return matched
end

local function array_includes(state, arguments)
  local expected = arguments[1]
  local tested = arguments[2]
  local matched = false

  for i,v in ipairs(tested) do
    matched = matched or v == expected
  end
  return matched
end

local function empty_array(state, arguments)
  local test = arguments[1]
  return #test == 0
end

say:set("assertion.array_matches.positive", "Expected %s to match: %s")
say:set("assertion.array_matches.negative", "Expected %s to not match: %s")
assert:register("assertion", "array_matches", array_matches, "assertion.array_matches.positive", "assertion.array_matches.negative")

say:set("assertion.array_includes.positive", "Expected %s to be in: %s")
say:set("assertion.array_includes.negative", "Expected %s to be in: %s")
assert:register("assertion", "array_includes", array_includes, "assertion.array_includes.positive", "assertion.array_includes.negative")

say:set("assertion.empty_array.positive", "Expected %s to be empty")
say:set("assertion.empty_array.negative", "Expected %s to not be empty")
assert:register("assertion", "empty_array", empty_array, "assertion.empty_array.positive", "assertion.empty_array.negative")
