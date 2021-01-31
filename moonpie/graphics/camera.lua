-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Camera = {}

function Camera:new()
  local c = setmetatable({}, { __index = Camera })
  c.x = 0
  c.y = 0
  c.scale_x = 1
  c.scale_y = 1
  return c
end

function Camera:setPosition(x, y)
  self.x = x
  self.y = y
end

function Camera:activate()
  love.graphics.push()
  love.graphics.translate(self.x, self.y)
  love.graphics.scale(self.scale_x, self.scale_y)
end

function Camera:deactivate()
  love.graphics.pop()
end

function Camera:scale(sx, sy)
  self.scale_x = sx
  self.scale_y = sy
end

function Camera:projection(world_width, world_height, screen_width, screen_height)
  self:scale(screen_width/world_width, screen_height/world_height)
end

return Camera