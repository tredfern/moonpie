-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local ScriptTools = {}

function ScriptTools.getPath()
  local str = debug.getinfo(2, "S").source:sub(2)
  str = string.gsub(str, "\\", "/")
  return str:match("(.*/)")
end


return ScriptTools