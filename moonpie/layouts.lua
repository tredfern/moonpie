-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local align = require("moonpie.alignment")

local layouts = {}


function layouts.children(node, width)
  local x, y = 0, 0
  local line_height, max_width, max_height = 0, 0, 0

  for _, v in pairs(node.children) do
    if v.layout then v:layout(node) end

    if x > 0 and x + v.box:width() > width then
      x = 0
      y = y + line_height
      max_height = max_height + line_height
      line_height = 0
    end

    local a = v.component and v.component.align or "left"
    v.box.x, v.box.y = align(a, x, width, v.box:width()), y
    x = v.box.x + v.box:width()
    line_height = math.max(v.box:height(), line_height)
    max_width = math.max(max_width, x)
  end

  max_height = max_height + line_height

  return max_width, max_height
end

function layouts.max_width(node, p)
  return node.component.width or
    (p.box.content.width
      - node.box.margin.left - node.box.margin.right
      - node.box.padding.left - node.box.padding.right
      - node.box.border.left - node.box.border.right)
end

function layouts.standard(node, parent)
  if parent then node.box.parent = parent.box end
  node.box.content.width = layouts.max_width(node, parent)
  node.box.content.height = 0

  local w, h = node:layout_children(node.box.content.width)

  if node.component.display == "inline" then
    node.box.content.width = node.component.width or w
  end
  node.box.content.height = node.component.height or h

  node.component.refresh_layout = nil
end

return layouts
