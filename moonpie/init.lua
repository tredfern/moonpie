-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local RenderEngine = require("moonpie.render_engine")
local mouse = require("moonpie.mouse")
local keyboard = require "moonpie.keyboard"
local layers = {}
local layer_order = { "ui", "modal", "debug" }

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
  },
  utility = {
    timer = require "moonpie.utility.timer"
  }
}

moonpie.logger.info("Loaded Moonpie modules")

local debug
local frame_number = 0
local paint_timer = moonpie.utility.timer:new("UI Paint")
local update_timer = moonpie.utility.timer:new("UI Update")

function moonpie.paint()
  paint_timer:start()
  frame_number = frame_number + 1
  for _, v in ipairs(layer_order) do
    if layers[v] then
      layers[v]:paint()
    end
  end

  -- Debug stats
  local stats = love.graphics.getStats()
  stats.frame_number = frame_number
  paint_timer:stop()
  debug:update({ stats = stats, paint_timer = paint_timer, update_timer = update_timer })
end

function moonpie.render(layer_name, ...)
  layers[layer_name] = RenderEngine(...)
  return layers[layer_name]
end

function moonpie.update()
  update_timer:start()
  keyboard:update()
  for _, v in ipairs(layer_order) do
    if layers[v] then
      layers[v]:update(mouse)
    end
  end
  -- HACK: Mouse isn't handled smoothly
  mouse:update_button_states()
  update_timer:stop()
end

function moonpie.load_stylesheet()
  require("moonpie.stylesheet")(moonpie)
end

function moonpie.load_debug()
  debug = moonpie.components.debug_panel()
  moonpie.render("debug", debug )
  debug.hidden = true
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
