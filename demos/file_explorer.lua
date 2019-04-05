-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"

Components("folder_tree", function()
  return {
    background_color = "invert_background",
    color = "invert_text",
    border_color = "accent",
    border = 1,
    {
      border_color = "accent",
      border = 1,
      Components.h3({ text = "Folders" })
    }
  }
end)

Components("file_list", function(props)
  return {
    current_directory = props.current_directory,
    background_color = "invert_background",
    color = "invert_text",
    border_color = "accent",
    border = 1,
    render = function(self)
      return {
        {
          border_color = "accent",
          border = 1,
          Components.h3({ text = "Files" })
        }, {
          Components.list({
            color = "invert_text",
            items = love.filesystem.getDirectoryItems(self.current_directory)
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
    border_color = "accent",
    border = 1,
    Components.folder_tree({ width = "20%", height = "100%" }),
    Components.file_list({ width = "78%", current_directory = "", height = "100%" })
  }
end