-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local files = require "moonpie.utility.files"
local Font = {
  registered = {}
}

function Font:create(path, name)
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

function Font:register(path, alias)
  local name = files.getName(path)
  local f = Font.registered[name]

  if not f then
    f = Font:create(path, name)
  end

  Font.registered[f.name] = f
  if alias then Font.registered[alias] = f end

  return f
end

function Font:get(path_name, size)
  local f = self.registered[path_name] or self:register(path_name)
  if size == nil then
    return f
  end

  return f(size)
end

function Font.pick(tbl)
  if tbl.font then
    return tbl.font
  end

  if tbl.fontName and tbl.fontSize then
    return Font:get(tbl.fontName, tbl.fontSize)
  end

  return Font:get("not-set", 12)
end

setmetatable(Font, {
  __call = Font.get
})

return Font
