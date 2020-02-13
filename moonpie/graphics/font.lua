-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local files = require "moonpie.utility.files"
local font = {
  registered = {}
}


function font:register(path)
  local name = files.get_name(path)
  if font.registered[name] then
    return font.registered[name]
  end

  local f = setmetatable({
    path = path,
    name = name,
  }, {
    __call = function(f, size)
      if not f[size] then
        f[size] = love.graphics.newFont(f.path, size)
      end
      return f[size]
    end
  })
  font.registered[f.name] = f

  return f
end

setmetatable(font, {
  __call = font.register
})

return font
