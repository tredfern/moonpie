-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local MATCH_PATTERN = "{{(%w+)}}"

local function convert_props_to_string(props)
  local out = {}
  for k, v in pairs(props) do
    out[k] = tostring(v)
  end
  return out
end

return function(template, props)
  local p = convert_props_to_string(props)
  if template then
    return string.gsub(template, MATCH_PATTERN, p)
  end
end
