-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(...)
  return{
    n = select('#', ...),
    ...
  }
end