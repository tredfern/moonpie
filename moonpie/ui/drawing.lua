-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local drawing = {}
local colors = require "moonpie.graphics.colors"
local image = require "moonpie.graphics.image"

function drawing.standard(node)
  if node.hidden then return end
  love.graphics.push()
  love.graphics.translate(node.box.x, node.box.y)
  drawing.draw_background(node)
  drawing.draw_border(node)
  drawing.image(node)

  love.graphics.translate(node.box:content_position())

  for _, v in ipairs(node.children) do
    v:paint()
  end
  love.graphics.pop()
end

function drawing.draw_background(node)
  if node.background_color then
    love.graphics.push()
    love.graphics.translate(node.box:background_position())
    love.graphics.setColor(colors(node.background_color, node.opacity))
    local w, h = node.box:background_size()
    love.graphics.rectangle("fill", 0, 0, w, h,
      node.corner_radius_x or 0, node.corner_radius_y or 0)
    love.graphics.pop()
  end
end

function drawing.draw_border(node)
  if node.border then
    love.graphics.push()
    local x, y = node.box:border_position()
    x = x + node.border / 2
    y = y + node.border / 2

    love.graphics.translate(x, y)
    love.graphics.setColor(colors(node.border_color))
    love.graphics.setLineWidth(node.border)
    local w, h = node.box:border_size()
    w = w - node.border
    h = h - node.border
    love.graphics.rectangle("line", 0, 0, w, h,
      node.corner_radius_x or 0, node.corner_radius_y or 0)
    love.graphics.pop()
  end
end

function drawing.image(node)
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

return drawing
