-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


function spy_to_func(s)
  return function(...) return s(...) end  
end