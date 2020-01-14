-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Scene = {}

function Scene:new()
  local scn = { }
  setmetatable(scn, { __index = self })

  local moonpie = require("moonpie")
  moonpie.update_callbacks:add(scn, "update")
  return scn
end

function Scene:ui(screen)
  require("moonpie").render("ui", screen)
end

function Scene:update()
end

return Scene