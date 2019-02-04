-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local Block = require(BASE .. "block")
local Text = require(BASE .. "text")

return function(...)
  local r = Block()

  for _, v in ipairs({...}) do
    local new_block = Block(v)
    if v.text then
      new_block:add(Text(v))
    end
    r:add(new_block)
  end

  r:layout({
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight()
  })

  return r
end
