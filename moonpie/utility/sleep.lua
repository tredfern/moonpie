-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(s)
  local ntime = os.clock() + s
  repeat until os.clock() > ntime
end
