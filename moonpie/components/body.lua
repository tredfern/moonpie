-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.components.component"

Component("body", function(props)
  local b = {}

  for i, v in ipairs(props) do
    b[i] = v
  end

  return b
end)
