-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local component = require "moonpie.components.component"

component("section", function(props)
  local s = {}
  for i, v in ipairs(props) do
    s[i] = v
  end
  return s
end)
