-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(props)
  return function()
    love.graphics.print(props.text)
  end
end
