-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.components.component"
local image = require "moonpie.image"
local layouts = require "moonpie.layouts"
local renderers = require "moonpie.renderers"

Component("image", function(props)
  local i = {
    layout = layouts.image,
    paint = renderers.image
  }

  i.image = image.load(props.src)
  return i
end)
