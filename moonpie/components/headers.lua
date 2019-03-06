-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require("moonpie.components.component")

Component("h1", function(props)
  return Component.text({ text = props.text })
end)

Component("h2", function(props)
  return Component.text({ text = props.text })
end)

Component("h3", function(props)
  return Component.text({ text = props.text })
end)
