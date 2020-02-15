-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Conf = require "moonpie.configuration"
local csv = require("moonpie.ext.csv")
local colors = { }

function colors.convert_hex(hex)
    hex = hex:gsub("#","")
    local r,g,b
    if (string.len(hex) == 6) then
      r = tonumber("0x"..hex:sub(1,2))/255
      g = tonumber("0x"..hex:sub(3,4))/255
      b = tonumber("0x"..hex:sub(5,6))/255
    elseif (string.len(hex) == 3) then
      r = tonumber("0x"..hex:sub(1,1)..hex:sub(1,1))/255
      g = tonumber("0x"..hex:sub(2,2)..hex:sub(2,2))/255
      b = tonumber("0x"..hex:sub(3,3)..hex:sub(3,3))/255
    end

    return { r, g, b, 1}
end

-- TODO: Remove hardcoded color directory
local csv_file = love.filesystem.read(Conf.assets_path .. "colors.csv")
local contents = csv.openstring(csv_file)
for fields in contents:lines() do
  colors[fields[1]]= colors.convert_hex(fields[3])
end
colors.transparent = {0,0,0,0}


function colors.redistribute_rgb(clr)
  local r, g, b, a = clr[1], clr[2], clr[3], clr[4]
  local m = math.max(r, g, b)
  if m <= 1.0 then
    return { r, g, b, a }
  end

  -- maxed out
  local total = r + g + b
  if total >= 3 then
    return { 1, 1, 1, a }
  end
  local x = (3 - total) / (3 * m - total)
  local gray = 1 - x * m

  return { gray + x * r, gray + x * g, gray + x * b, a }
end

function colors.lighten(clr, multiplier)
  return colors.redistribute_rgb({
    clr[1] * multiplier,
    clr[2] * multiplier,
    clr[3] * multiplier,
    clr[4]
  })
end

function colors.get_color(self, clr, opacity)
  if type(clr) == "table" then
    return { clr[1], clr[2], clr[3], opacity or clr[4] }
  elseif type(clr) == "string" then
    return self(self[clr], opacity)
  elseif type(clr) == "function" then
    return self(clr(self), opacity)
  end
  return nil
end

function colors.is_color(v)
  return type(v) == "table" and #v == 4
end

function colors.all()
  local out = {}
  for _, v in pairs(colors) do
    if colors.is_color(v) then
      out[#out + 1] = v
    end
  end
  return out
end

setmetatable(colors, {
  __call = colors.get_color
})

return colors
