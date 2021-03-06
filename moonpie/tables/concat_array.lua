-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local pack = require "moonpie.tables.pack"
return function(...)
  local args = pack(...)
  local out = {}
  for i = 1, args.n do
    if args[i] then
      for _, v in ipairs(args[i]) do
        out[#out + 1] = v
      end
    end
  end

  return out
end