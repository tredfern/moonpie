-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local Block = require(BASE .. "block")
local Text = require(BASE .. "text")
local Component = require(BASE .. "component")

local function build_item(item)
  local new_block = Block(item)
  if item.text then
    new_block:add(Text(item))
  end

  for _, v in ipairs(item) do
    new_block:add(build_item(v))
  end
  return new_block
end

return function(...)
 local r = Block(Component.root)

  for _, v in ipairs({...}) do
    r:add(build_item(v))
  end

  r:layout()

  return r
end
