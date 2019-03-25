-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local RenderEngine = require "moonpie.render_engine"
local layers = {}

layers.ui = RenderEngine()
layers.modal = RenderEngine()
layers.debug = RenderEngine()

function layers.render_order()
  return {
    layers.ui,
    layers.modal,
    layers.debug
  }
end


return layers
