-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local assert = require("luassert")
local say = require("say")

function fail()
  return false
end


say:set("assertion.fail.positive", "Test incomplete")
say:set("assertion.fail.negative", "Test passing I guess")
assert:register("assertion", "fail", fail, "assertion.fail.positive", "assertion.fail.negative")