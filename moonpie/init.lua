-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local RenderEngine = require("moonpie.ui.render_engine")
local mouse = require("moonpie.mouse")
local keyboard = require "moonpie.keyboard"

local moonpie = {
  class = require "moonpie.class",
  collections = require "moonpie.collections",
  ecs = require "moonpie.ecs",
  events = require "moonpie.events",
  graphics = {
    camera = require "moonpie.graphics.camera",
    colors = require "moonpie.graphics.colors",
    font = require "moonpie.graphics.font",
    icons = require "moonpie.graphics.icons",
    image = require "moonpie.graphics.image"
  },
  keyboard = keyboard,
  math = require "moonpie.math",
  mouse = mouse,
  logger = require "moonpie.logger",
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

  moonpie.events.before_paint:trigger()
  RenderEngine.paint()
  moonpie.events.after_paint:trigger()

  -- Debug stats
  local stats = love.graphics.getStats()
  stats.frame_number = frame_number
  paint_timer:stop()
  debug:update({ stats = stats, paint_timer = paint_timer, update_timer = update_timer })
end

function moonpie.render(layer_name, ...)
  RenderEngine.render_all(layer_name, ...)
end

function moonpie.update()
  update_timer:start()

  moonpie.events.before_update:trigger()
  RenderEngine.update(mouse)
  -- HACK: Mouse isn't handled smoothly
  mouse:update_button_states()
  moonpie.events.after_update:trigger()
  update_timer:stop()
end

function moonpie.keypressed(key, scancode, isrepeat)
  keyboard:keypressed(key, scancode, isrepeat)
end

function moonpie.keyreleased(key, scancode)
  keyboard:keyreleased(key, scancode)
end

function moonpie.load_stylesheet()
  require("moonpie.ui.stylesheet")(moonpie)
end

function moonpie.resize(width, height)
  moonpie.events.window_resize:trigger(width, height)
end

function moonpie.load_debug()
  debug = moonpie.ui.components.debug_panel()
  moonpie.render("debug", debug )
  debug.hidden = true
  RenderEngine.layers.debug.root.background_color = "transparent"
  RenderEngine.layers.debug.root.color = "background"
  keyboard:hotkey("`", function() debug.hidden = not debug.hidden end)
end

moonpie.ui.themes.standard(moonpie)
moonpie.ui.themes.light_mode(moonpie)
moonpie.load_stylesheet()
moonpie.load_debug()

moonpie.logger.debug("Moonpie Loading Complete")

return moonpie