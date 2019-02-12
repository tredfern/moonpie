-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local csv = require(BASE .. "ext.csv")
local colors = { }

function colors.convert_hex(hex)
    hex = hex:gsub("#","")
    if (string.len(hex) == 6) then
        return
            tonumber("0x"..hex:sub(1,2))/255,
            tonumber("0x"..hex:sub(3,4))/255,
            tonumber("0x"..hex:sub(5,6))/255

    elseif (string.len(hex) == 3) then
        return
            tonumber("0x"..hex:sub(1,1)..hex:sub(1,1))/255,
            tonumber("0x"..hex:sub(2,2)..hex:sub(2,2))/255,
            tonumber("0x"..hex:sub(3,3)..hex:sub(3,3))/255
    end
end

-- TODO: Remove hardcoded color directory
local csv_file = love.filesystem.read("moonpie/assets/colors.csv")
local contents = csv.openstring(csv_file)
for fields in contents:lines() do
    local r,g,b = colors.convert_hex(fields[3])
    colors[fields[1]]={r, g, b, 1, displayname=fields[2]}
end

return colors
