-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local files = { }
local unpacker = require "moonpie.utility.unpack"

function files.assertExists(path)
  if love.filesystem.getInfo(path) == nil then
    error("File does not exist: " .. path)
  end
end

function files.splitPathComponents(path)
  return string.match(path, "(.-)([^\\/]-)%.?([^%.\\/]*)$")
end

function files.getName(path)
  local _, file, _ = files.splitPathComponents(path)
  return file
end

function files.mergePath(path, name)
  if string.sub(path, -1) ~= "/" then
    return path .. "/" .. name
  end
  return path .. name
end

function files.find(path, include_pattern, exclude_pattern)
  local list = require "moonpie.collections.list"
  local results = list:new()
  local items = love.filesystem.getDirectoryItems(path)
  for _, v in ipairs(items) do
    local p = files.mergePath(path, v)
    local info = love.filesystem.getInfo(p)

    if info.type == "directory" then
      results:add(unpacker(files.find(p, include_pattern, exclude_pattern)))
    elseif include_pattern == nil or string.find(p, include_pattern) ~= nil then
      if exclude_pattern == nil or string.find(p, exclude_pattern) == nil then
        results:add(p)
      end
    end
  end

  return results
end

return files