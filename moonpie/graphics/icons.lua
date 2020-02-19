-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Conf = require "moonpie.configuration"
local Files = require "moonpie.utility.files"

local icons = {}

local function load()
  local list = Files.find(Conf.icons_path)
  for _, v in ipairs(list) do
    local n = Files.get_name(v)
    icons[n] = v
  end
  icons.loaded = true
end

function icons.get(icon)
  if not icons.loaded then
    load()
  end
  return icons[icon]
end

return icons