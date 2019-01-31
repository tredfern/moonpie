-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(props)
  return function()
    if props.font then love.graphics.setFont(props.font) end
    if props.color then love.graphics.setColor(props.color) end

    love.graphics.print(props.text)
  end
end
