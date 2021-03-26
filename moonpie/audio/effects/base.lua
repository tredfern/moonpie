-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(audio, effect)
  return setmetatable({
    play = function(_, config)
      audio:play(
        function(instance)
          if effect then effect(instance) end
          if config then config(instance) end
        end)
    end
  }, {
    __index = audio
  })
end