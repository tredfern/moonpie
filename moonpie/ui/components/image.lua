-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"
local image = require "moonpie.graphics.image"
local layouts = require "moonpie.ui.layouts"

Component("image", function(props)
  local source = props.source

  local i = {
    layout = layouts.image,
    source = source
  }

  i.image = image.load(source)
  return i
end)
