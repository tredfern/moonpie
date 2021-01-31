-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local files = require "moonpie.utility.files"
local font = {
  registered = {}
}

function font:create(path, name)
  return setmetatable({
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
end

function font:register(path, alias)
  local name = files.get_name(path)
  local f = font.registered[name]

  if not f then
    f = font:create(path, name)
  end

  font.registered[f.name] = f
  if alias then font.registered[alias] = f end

  return f
end

function font:get(path_name, size)
  local f = self.registered[path_name] or self:register(path_name)
  if size == nil then
    return f
  end

  return f(size)
end

function font.pick(tbl)
  if tbl.font then
    return tbl.font
  end

  if tbl.fontName and tbl.fontSize then
    return font:get(tbl.fontName, tbl.fontSize)
  end

  return font:get("not-set", 12)
end

setmetatable(font, {
  __call = font.get
})

return font
