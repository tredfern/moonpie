-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local List = require "moonpie.collections.list"

local function getName(directory, name)
  return directory.."/"..name
end

local function get_directories(directory)
  local items = love.filesystem.getDirectoryItems(directory)
  local out = List:new()
  for _, v in ipairs(items) do
    if love.filesystem.isDirectory(getName(directory, v)) then
      out:add(v)
    end
  end
  return out
end

local function get_files(directory)
  local items = love.filesystem.getDirectoryItems(directory)
  local out = List:new()
  for _, v in ipairs(items) do
    if love.filesystem.isFile(getName(directory, v)) then
      out:add(v)
    end
  end
  return out
end

Components("folder_tree", function(props)
  return {
    current_directory = props.current_directory,
    backgroundColor = "invert_background",
    color = "invert_text",
    borderColor = "accent",
    border = 1,
    render = function(self)
      return {
        {
          borderColor = "accent",
          border = 1,
          Components.h3({ text = "Folders" })
        }, {
          Components.list({
            color = "invert_text",
            items = get_directories(self.current_directory)
          })
        }
      }
    end
  }
end)

Components("file_list", function(props)
  return {
    current_directory = props.current_directory,
    backgroundColor = "invert_background",
    color = "invert_text",
    borderColor = "accent",
    border = 1,
    render = function(self)
      return {
        {
          borderColor = "accent",
          border = 1,
          Components.h3({ text = "Files" })
        }, {
          Components.list({
            color = "invert_text",
            items = get_files(self.current_directory)
          })
        }
      }
    end
  }
end)

return function()
  return {
    height = "70%",
    padding = 3,
    borderColor = "accent",
    border = 1,
    Components.folder_tree({ width = "20%", height = "100%", current_directory = "" }),
    Components.file_list({ width = "78%", current_directory = "", height = "100%" })
  }
end