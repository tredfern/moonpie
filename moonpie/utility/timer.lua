-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local timer = {}
timer.__index = timer

function timer:new(name)
  return setmetatable({
    total = 0,
    count = 0,
    max = 0,
    min = 0,
    name = name or "unnamed timer"
  }, timer)
end

function timer:start()
  self.start_time = love.timer.getTime()
end

function timer:stop()
  self.stop_time = love.timer.getTime()
  self.last = self.stop_time - self.start_time
  self.total = self.total + self.last
  self.count = self.count + 1
  self.max = math.max(self.last, self.max)
  self.min = self.min ~= 0 and math.min(self.min, self.last) or self.last
end

function timer:average()
  return self.total / self.count
end

return timer
