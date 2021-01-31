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
  drawing.drawBackground(node)
  drawing.drawBorder(node)
  drawing.image(node)
  drawing.customContent(node)

  love.graphics.translate(node.box.contentPosition.x, node.box.contentPosition.y)

  for _, v in ipairs(node.children) do
    v:paint()
  end
  love.graphics.pop()
end

function drawing.drawBackground(node)
  if node.backgroundColor then
    love.graphics.push()
    love.graphics.translate(node.box.backgroundPosition.x, node.box.backgroundPosition.y)
    love.graphics.setColor(colors(node.backgroundColor, node.opacity))
    local w, h = node.box.backgroundPosition.width, node.box.backgroundPosition.height
    if node.backgroundImage then
      local sx = image.scaleWidth(node.backgroundImage, w)
      local sy = image.scaleHeight(node.backgroundImage, h)
      love.graphics.draw(node.backgroundImage, 0, 0, 0, sx, sy)
    else
      love.graphics.rectangle("fill", 0, 0, w, h,
        node.cornerRadiusX or 0, node.cornerRadiusY or 0)
    end
    love.graphics.pop()
  end
end

function drawing.drawBorder(node)
  if node.border then
    love.graphics.push()
    local x, y = node.box.borderPosition.x, node.box.borderPosition.y
    x = x + node.border / 2
    y = y + node.border / 2

    love.graphics.translate(x, y)
    love.graphics.setColor(colors(node.borderColor))
    love.graphics.setLineWidth(node.border)
    local w, h = node.box.borderPosition.width, node.box.borderPosition.height
    w = w - node.border
    h = h - node.border
    love.graphics.rectangle("line", 0, 0, w, h,
      node.cornerRadiusX or 0, node.cornerRadiusY or 0)
    love.graphics.pop()
  end
end

function drawing.image(node)
  if not node.image then return end
  local rot = 0
  local sx = image.scaleWidth(node.image, node.box.content.width)
  local sy = image.scaleHeight(node.image, node.box.content.height)

  local clr = node.color or { 1, 1, 1, 1 }
  love.graphics.push()
  love.graphics.translate(node.box.contentPosition.x, node.box.contentPosition.y)
  love.graphics.setColor(colors(clr))
  love.graphics.draw(node.image, 0, 0, rot, sx, sy)
  love.graphics.pop()
end

function drawing.customContent(node)
  if not node.drawComponent then return end
  love.graphics.push()
  love.graphics.translate(node.box.contentPosition.x, node.box.contentPosition.y)
  node:drawComponent()
  love.graphics.pop()
end

return drawing
