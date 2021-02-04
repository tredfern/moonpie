-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Audio = { }

local resourcePool = {
  static = {},
  stream = {}
}

local function getSoundData(fileName, mode)
  resourcePool[mode][fileName] =
    resourcePool[mode][fileName]
      or love.audio.newSource(fileName, mode)
  return resourcePool[mode][fileName]
end

function Audio.getStatic(soundFile)
  return getSoundData(soundFile, "static")
end

function Audio.getStreaming(soundFile)
  return getSoundData(soundFile, "stream")
end

return setmetatable(Audio, { __index = love.audio })