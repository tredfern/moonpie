-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local assert = require("luassert")
local say = require("say")

function fail()
  return false
end


function callable(_, args)
  local isCallable = require "moonpie.utility.is_callable"
  return isCallable(args[1])
end


say:set("assertion.fail.positive", "Test incomplete")
say:set("assertion.fail.negative", "Test passing I guess")
assert:register("assertion", "fail", fail, "assertion.fail.positive", "assertion.fail.negative")

say:set("assertion.callable.positive", "Expected %s to be callable")
say:set("assertion.callable.negative", "Expected %s to not be callable")
assert:register("assertion", "callable", callable, "assertion.callable.positive", "assertion.callable.negative")