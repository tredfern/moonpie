-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local reverse = require "moonpie.collections.iterators.reverse"
local Component = require "moonpie.ui.components.component"
local logger = require "moonpie.logger"

return function()
  return {
    render = function()
      local out = {}

      for v in reverse(logger.entries, 20) do
        out[#out + 1] = {
            Component.text({
            text = "{{date}} - {{level}}: {{message}}",
            date = os.date("%c", v.timestamp),
            level = v.level,
            message = v.message
          })
        }
      end

      return out
    end
  }
end
