-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local RenderEngine = require("moonpie.render_engine")
local mouse = require("moonpie.mouse")
local keyboard = require "moonpie.keyboard"
local layers = {}
local layer_order = { "ui", "debug" }

local moonpie = {
  colors = require "moonpie.colors" ,
  collections = require "moonpie.collections",
  components = require "moonpie.components",
  font = require "moonpie.font",
  keyboard = keyboard,
  mouse = mouse,
  layers = layers,
  logger = require "moonpie.logger",
  styles = require "moonpie.styles",
  tween = require "moonpie.ext.tween",
  themes = {
    standard = require "moonpie.themes.standard",
    light_mode = require "moonpie.themes.light_mode",
    dark_mode = require "moonpie.themes.dark_mode"
  }
}

moonpie.logger.info("Loaded Moonpie modules")

local debug

function moonpie.paint()
  for _, v in ipairs(layer_order) do
    if layers[v] then
      layers[v]:paint()
    end
  end
  debug:update({ stats = love.graphics.getStats() })
end

function moonpie.render(layer_name, ...)
  layers[layer_name] = RenderEngine(...)
  return layers[layer_name]
end

function moonpie.update()
  keyboard:update()
  for _, v in ipairs(layer_order) do
    if layers[v] then
      layers[v]:update(mouse)
    end
  end
end

function moonpie.load_stylesheet()
  require("moonpie.stylesheet")(moonpie)
end

function moonpie.load_debug()
  debug = moonpie.components.debug_panel()
  moonpie.render("debug", debug )
  debug.hidden = false
  layers["debug"].root.background_color = "transparent"
  layers["debug"].root.color = "background"
  keyboard:hotkey("`", function() debug.hidden = not debug.hidden end)
end


moonpie.themes.standard(moonpie)
moonpie.themes.light_mode(moonpie)
moonpie.load_stylesheet()
moonpie.load_debug()

moonpie.logger.debug("Moonpie Loading Complete")

return moonpie
