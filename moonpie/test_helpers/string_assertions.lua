-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local assert = require("luassert")
local say = require("say")

function contains(state, arguments)
  local expected = arguments[1]
  local tested = arguments[2]
  return string.find(tested, expected) ~= nil
end


say:set("assertion.contains.positive", "Expected %s to be contained in: %s . Check for magic characters ().%%+-*?[^$")
say:set("assertion.contains.negative", "Expected %s to not be contained in: %s . Check for magic characters ().%%+-*?[^$")
assert:register("assertion", "contains", contains, "assertion.contains.positive", "assertion.contains.negative")