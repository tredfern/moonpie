-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local MATCH_PATTERN = "{{(%w+)}}"

return function(template, props)
  if template then
    return string.gsub(template, MATCH_PATTERN, props)
  end
end
