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

return image
