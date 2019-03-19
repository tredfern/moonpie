-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.components.component"
local log = require "moonpie.components.debug.log_entries"

Component("fps_counter", function()
  return Component.text({
    text = "FPS: {{fps}}",
    fps = love.timer.getFPS()
  })
end)

Component("love_version", function()
  return Component.text({
    text = "Löve: {{version}}",
    version = love.getVersion()
  })
end)

Component("love_stats", function(props)
  return Component.section({
    Component.text({ text = "STATS" }),
    Component.text({ text = [[
        Draw Calls: {{drawcalls}}
        Canvas Switches: {{canvasswitches}}
        Texture Memory: {{texturememory}}
        Images: {{images}}
        Canvases = {{canvases}}
        Fonts = {{fonts}}
      ]],
      drawcalls = props.stats.drawcalls,
      texturememory = props.stats.texturememory,
      canvasswitches = props.stats.canvasswitches,
      images = props.stats.images,
      canvases = props.stats.canvases,
      fonts = props.stats.fonts,
    })
  })
end)


Component("debug_panel", function()
  return {
    stats = love.graphics.getStats(),
    style = "debug_panel",
    render = function(self)
      return {
        Component.text({ text = "Debug Panel" }),
        Component.section({
          Component.love_version(),
        }),
        Component.section({
          Component.fps_counter()
        }),
        Component.love_stats({ stats = self.stats }),
        Component.section({
          Component.h2({ text = "Log" }),
          log()
        })
      }
    end
  }
end)
