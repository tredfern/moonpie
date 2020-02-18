-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local component = require "moonpie.ui.components.component"
local icons = require "moonpie.graphics.icons"
local image = require "moonpie.graphics.image"

component("icon", function(props)
  local layouts = require "moonpie.ui.layouts"
  return {
    layout = layouts.image,
    image = image.load(icons.get(props.icon))
  }
end)

component("icon_xsmall", function(props) return component.icon(props) end)
component("icon_small", function(props) return component.icon(props) end)
component("icon_medium", function(props) return component.icon(props) end)
component("icon_large", function(props) return component.icon(props) end)
component("icon_xlarge", function(props) return component.icon(props) end)