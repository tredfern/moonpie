-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.components.component"

Component("inline", function(props)
  local s = {}
  for i, v in ipairs(props) do
    s[i] = v
    v.display = "inline"
  end
  return s
end)
