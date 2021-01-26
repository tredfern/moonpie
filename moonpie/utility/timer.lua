-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local timer = {}
timer.__index = timer

function timer:new(name, range)
  return setmetatable({
    total = 0,
    count = 0,
    max = 0,
    min = 0,
    range = range or 100,
    next = 1,
    results = {},
    name = name or "unnamed timer"
  }, timer)
end

function timer:start()
  self.start_time = love.timer.getTime()
end

function timer:stop()
  self.stop_time = love.timer.getTime()
  self.last = self.stop_time - self.start_time

  if self.last > 0 then
    -- store result
    self.results[self.next] = self.last
    self.next = self.next + 1
    if self.next > self.range then
      self.next = 1
    end

    self.total = tables.sum(self.results)
    self.count = math.min(self.count + 1, self.range)
    self.max = tables.max(self.results)
    self.min = tables.min(self.results)
  end
end

function timer:average()
  return self.total / self.count
end

return timer
