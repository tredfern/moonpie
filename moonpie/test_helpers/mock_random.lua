-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Queue = require "moonpie.collections.queue"
local results = Queue:new()
local oldrandom = math.random

local function setreturnvalues(o)
  for _, v in ipairs(o) do
    results:enqueue(v)
  end
end

local function nextresult(...)
  if results:isempty() then
    return oldrandom(...)
  end

  return results:dequeue()
end

math.random = nextresult

return {
  setreturnvalues = setreturnvalues
}
