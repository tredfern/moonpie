-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"
local log = require "moonpie.ui.components.debug.log_entries"
local statistics = require "moonpie.statistics"

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

Component("frame_number", function(props)
  return Component.text({
    text = "Frame Number: {{frame}}",
    frame = props.frame_number
  })
end)

Component("dbg_focused", function()
  local c = require("moonpie.ui.user_focus"):getFocus()
  if c then
    return Component.text({
      text = "Focused: {{name}}({{id}})",
      id = c.id,
      name = c.name
    })
  end
  return Component.text({ text = "Focused: ---"})
end)

Component("love_stats", function(props)
  return {
    {
    Component.text({ text = [[
Draw Calls: {{drawcalls}}
Canvas Switches: {{canvasswitches}}
Texture Memory: {{texturememory}}
Images: {{images}}
Canvases = {{canvases}}
Fonts = {{fonts}}
Nodes = {{nodes}}
      ]],
      drawcalls = props.stats.drawcalls,
      texturememory = props.stats.texturememory,
      canvasswitches = props.stats.canvasswitches,
      images = props.stats.images,
      canvases = props.stats.canvases,
      fonts = props.stats.fonts,
      nodes = statistics.nodes
    }) },
    {
      Component.fps_counter(),
    },
    {
      Component.memory_stats()
    },
    {
      Component.frame_number({ frame_number = props.stats.frame_number })
    }
  }
end)


Component("debug_panel", function()
  return {
    stats = love.graphics.getStats(),
    style = "debug_panel",
    version = Component.love_version(),
    profiler = Component.profile_report(),

    render = function(self)
      return {
        Component.text({ text = "Debug Panel" }),
        {
          style = "debug_tool",
          {
            self.version
          },
          {
            width = "30%",
            Component.love_stats({ stats = self.stats }),
          },
          {
            width = "30%",
            Component.timer_display({ timer = self.paint_timer }),
            Component.timer_display({ timer = self.update_timer })
          },
          {
            width = "30%",
            Component.display_settings(),
            Component.dbg_focused()
          }
        },
        {
          style = "debug_tool",
          self.profiler,
        },
        {
          style = "debug_tool",
          Component.h3({ color = "white", text = "Log" }),
          log()
        },
      }
    end
  }
end)
