-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local RenderEngine = require("moonpie.ui.render_engine")
local mouse = require("moonpie.mouse")
local keyboard = require "moonpie.keyboard"

local moonpie = {
  audio = require "moonpie.audio",
  class = require "moonpie.class",
  collections = require "moonpie.collections",
  events = require "moonpie.events",
  graphics = {
    camera = require "moonpie.graphics.camera",
    colors = require "moonpie.graphics.colors",
    font = require "moonpie.graphics.font",
    icons = require "moonpie.graphics.icons",
    image = require "moonpie.graphics.image"
  },
  input_handler = require "moonpie.ui.input_handler",
  keyboard = keyboard,
  math = require "moonpie.math",
  mouse = mouse,
  layers = require "moonpie.ui.layers",
  logger = require "moonpie.logger",
  tables = require "moonpie.tables",
  ui = {
    components = require "moonpie.ui.components",
    current = RenderEngine,
    styles = require "moonpie.ui.styles",
    themes = {
      standard = require "moonpie.themes.standard",
      light_mode = require "moonpie.themes.light_mode",
      dark_mode = require "moonpie.themes.dark_mode"
    },
  },
  utility = require "moonpie.utility"
}

moonpie.logger.info("Loaded Moonpie modules")

local debug
local frame_number = 0
local paint_timer = moonpie.utility.timer:new("UI Paint")
local update_timer = moonpie.utility.timer:new("UI Update")

function moonpie.paint()
  paint_timer:start()
  frame_number = frame_number + 1

  moonpie.events.beforePaint:trigger()
  RenderEngine.paint()
  moonpie.events.afterPaint:trigger()

  -- Debug stats
  local stats = love.graphics.getStats()
  stats.frame_number = frame_number
  paint_timer:stop()
  debug:update({ stats = stats, paint_timer = paint_timer, update_timer = update_timer })
end

function moonpie.render(node, layer_name)
  layer_name = layer_name or moonpie.layers.UI
  return RenderEngine.renderAll(layer_name, node)
end

function moonpie.modal(node)
  return moonpie.render(node, moonpie.layers.MODAL)
end

function moonpie.update()
  update_timer:start()

  moonpie.events.beforeUpdate:trigger()
  RenderEngine.update(mouse)
  -- HACK: Mouse isn't handled smoothly
  mouse:update()
  moonpie.events.afterUpdate:trigger()
  update_timer:stop()
end

function moonpie.keyPressed(key, scancode, isrepeat)
  keyboard:keyPressed(key, scancode, isrepeat)
end

function moonpie.keyReleased(key, scancode)
  keyboard:keyReleased(key, scancode)
end

function moonpie.load_stylesheet()
  require("moonpie.ui.stylesheet")(moonpie)
end

function moonpie.resize(width, height)
  moonpie.events.windowResize:trigger(width, height)
end

function moonpie.load_debug()
  debug = moonpie.ui.components.debug_panel()
  moonpie.render(debug, "debug")
  debug.hidden = true
  RenderEngine.layers.debug.backgroundColor = "transparent"
  RenderEngine.layers.debug.color = "background"
  keyboard:hotkey("`", function() debug.hidden = not debug.hidden end)
end

function moonpie.testRender(c)
  return moonpie.render(c, "unit_test")
end

moonpie.ui.themes.standard(moonpie)
moonpie.ui.themes.light_mode(moonpie)
moonpie.load_stylesheet()
moonpie.load_debug()

moonpie.logger.debug("Moonpie Loading Complete")

return moonpie