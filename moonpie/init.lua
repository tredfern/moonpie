-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local layout_tree = require("moonpie.layout_tree")
local mouse = require("moonpie.mouse")
local layers = {}
local layer_order = {
  "ui", "debug"
}

local function check_node_for_refresh(n)
  if n.refresh_needed and n:refresh_needed() then
    return true
  end

  if n.children then
    for _, v in ipairs(n.children) do
      if check_node_for_refresh(v) then
        return true
      end
    end
  end

  return false
end

local moonpie
moonpie = {
  colors = require("moonpie.colors"),
  collections = require("moonpie.collections"),
  components = require("moonpie.components"),
  font = require("moonpie.font"),
  mouse = mouse,
  paint = function()
    for _, v in ipairs(layer_order) do
      if layers[v] then
        layers[v]:paint()
      end
    end
  end,
  layers = layers,
  layout = function(...)
    return moonpie.render("ui", ...)
  end,
  render = function(layer_name, ...)
    layers[layer_name] = layout_tree(...)
    return layers[layer_name]
  end,
  update = function()
    for _, v in ipairs(layer_order) do
      if layers[v] then
        mouse:update(layers[v])
        if check_node_for_refresh(layers[v]) then
          layers[v]:layout()
        end
      end
    end
  end,
  themes = {
    standard = require("moonpie.themes.standard"),
    light_mode = require("moonpie.themes.light_mode"),
    dark_mode = require("moonpie.themes.dark_mode")
  }
}

moonpie.themes.standard(moonpie)
moonpie.themes.light_mode(moonpie)

return moonpie
