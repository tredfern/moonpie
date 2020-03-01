-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local assert = require("luassert")
local say = require("say")

local function file_exists(state, arguments)
  local path = arguments[1]
  local f = io.open(path, "r")
  local result = f ~= nil
  if f then f:close() end
  return result
end


say:set("assertion.file_exists.positive", "File %s does not exist.")
say:set("assertion.file_exists.negative", "File %s exists and should not.")
assert:register("assertion", "file_exists", file_exists, "assertion.file_exists.positive", "assertion.file_exists.negative")