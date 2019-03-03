-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require("moonpie.components.component")
local layouts = require "moonpie.layouts"
local renderers = require "moonpie.renderers"

Component("text", {
  display = "inline",
  color = "text",
  layout = layouts.text,
  paint = renderers.text
})
