-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.ui.components.component"

Component("display_settings", function()
  local w, h, flags = love.window.getMode()
  return {
    Component.list({
      items = {
        Component.text({
          id = "display_settings_resolution",
          text = "Resolution: {{w}}x{{h}}",
          w = w, h = h
        }),
        Component.text({
          id = "display_settings_fullscreen",
          text = "Fullscreen: {{fullscreen}} ({{mode}})",
          fullscreen = flags.fullscreen, mode = flags.fullscreentype
        }),
        Component.text({
          id = "display_settings_refresh_rate",
          text = "Refresh Rate: {{rr}}hz",
          rr = flags.refreshrate
        }),
        Component.text({
          id = "display_settings_vsync",
          text = "Vsync: {{vsync}}",
          vsync = flags.vsync
        })
      }
    })
  }
end)
