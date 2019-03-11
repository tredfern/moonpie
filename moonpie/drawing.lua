-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local renderers = {}
local colors = require "moonpie.colors"
local image = require "moonpie.image"

function renderers.standard(node)
  love.graphics.push()
  love.graphics.translate(node.box.x, node.box.y)
  renderers.draw_border(node)
  renderers.draw_background(node)
  renderers.image(node)

  love.graphics.translate(node.box:content_position())

  for _, v in ipairs(node.children) do
    v:paint()
  end
  love.graphics.pop()
end

function renderers.draw_background(node)
  if node.background_color then
    love.graphics.push()
    love.graphics.translate(node.box:background_position())
    love.graphics.setColor(colors(node.background_color))
    local w, h = node.box:background_size()
    love.graphics.rectangle("fill", 0, 0, w, h,
      node.corner_radius_x or 0, node.corner_radius_y or 0)
    love.graphics.pop()
  end
end

function renderers.draw_border(node)
  if node.border then
    love.graphics.push()
    love.graphics.translate(node.box:border_position())
    love.graphics.setColor(colors(node.border_color))
    love.graphics.setLineWidth(node.border)
    local w, h = node.box:border_size()
    love.graphics.rectangle("line", 0, 0, w, h,
      node.corner_radius_x or 0, node.corner_radius_y or 0)
    love.graphics.pop()
  end
end

function renderers.image(node)
  if not node.image then return end
  local rot, sx, sy = 0, 1, 1
  if node.width then
    sx = image.scale_width(node.image, node.width)
  end
  if node.height then
    sy = image.scale_height(node.image, node.height)
  end

  local clr = node.color or { 1, 1, 1, 1 }
  love.graphics.push()
  love.graphics.translate(node.box:content_position())
  love.graphics.setColor(colors(clr))
  love.graphics.draw(node.image, 0, 0, rot, sx, sy)
  love.graphics.pop()
end

return renderers
