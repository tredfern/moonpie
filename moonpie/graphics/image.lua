-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local image = {}
local image_store = {}

function image.load(name)
  if not image_store[name] then
    local loaded = love.graphics.newImage(name)
    image_store[name] = loaded
  end

  return image_store[name]
end

function image.scale(i, target_width, target_height)
  return image.scale_width(i, target_width),
    image.scale_height(i, target_height)
end

function image.scale_width(i, target_width)
  return target_width / i:getWidth()
end

function image.scale_height(i, target_height)
  return target_height / i:getHeight()
end

return image
