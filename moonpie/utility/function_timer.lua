-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local FunctionTimer = {}
local Timer = require "moonpie.utility.timer"

function FunctionTimer:new(f)
  return setmetatable({
    func = f,
    timer = Timer:new()
  }, FunctionTimer)
end

function FunctionTimer:relay(...)
  self.timer:start()
  local out = {self.func(...)}
  self.timer:stop()
  return table.unpack(out)
end


FunctionTimer.__index = FunctionTimer
FunctionTimer.__call = FunctionTimer.relay
return FunctionTimer
