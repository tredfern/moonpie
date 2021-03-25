-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local SourceHandler = {}

function SourceHandler:constructor(audioClip)
  self.source = audioClip
  self.instances = {}
end

function SourceHandler:getFreeInstance()
  for _, v in ipairs(self.instances) do
    if not v:isPlaying() then
      return v
    end
  end

  local newInstance = self.source:clone()
  self.instances[#self.instances + 1] = newInstance
  return newInstance
end

function SourceHandler:play(setupSound)
  local instance = self:getFreeInstance()
  if setupSound then
    setupSound(instance)
  end
  instance:play()
  return instance
end

return class(SourceHandler)