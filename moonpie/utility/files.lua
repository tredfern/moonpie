-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local files = { }

function files.split_path_components(path)
  return string.match(path, "(.-)([^\\/]-)%.?([^%.\\/]*)$")
end

function files.get_name(path)
  local _, file, _ = files.split_path_components(path)
  return file
end

return files