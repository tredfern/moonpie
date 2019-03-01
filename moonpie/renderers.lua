-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local renderers = {}
local colors = require "moonpie.colors"

function renderers.standard(node)
  local e = node.component
  if node.component.hover and node:hover() then e = node.component.hover end

  love.graphics.push()
  love.graphics.translate(node.box.x, node.box.y)
  renderers.draw_border(node, e)
  renderers.draw_background(node, e)

  love.graphics.translate(node.box:content_position())

  for _, v in ipairs(node.children) do
    v:paint()
  end
  love.graphics.pop()
end

function renderers.draw_background(node, e)
  if e.background_color then
    love.graphics.push()
    love.graphics.translate(node.box:background_position())
    love.graphics.setColor(colors(e.background_color))
    local w, h = node.box:background_size()
    love.graphics.rectangle("fill", 0, 0, w, h,
      node.corner_radius_x or 0, node.corner_radius_y or 0)
    love.graphics.pop()
  end
end

function renderers.draw_border(node, e)
  if e.border then
    love.graphics.push()
    love.graphics.translate(node.box:border_position())
    love.graphics.setColor(colors(e.border_color))
    love.graphics.setLineWidth(e.border)
    local w, h = node.box:border_size()
    love.graphics.rectangle("line", 0, 0, w, h,
      node.corner_radius_x or 0, node.corner_radius_y or 0)
    love.graphics.pop()
  end
end


return renderers
