-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local base = require "moonpie.audio.effects.base"
local maths = require "moonpie.math"

return function(audio, min, max)
  return base(audio, function(instance)
    local pitchMod = maths.prandom(min, max)
    instance:setPitch(pitchMod)
  end)
end