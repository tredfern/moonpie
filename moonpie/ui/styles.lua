-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local str = require "moonpie.utility.string"
local reverse = require "moonpie.collections.iterators.reverse"
local list = require "moonpie.collections.list"

local styles = {}

local INHERITABLE = {
  color = true,
  font = true,
  font_name = true,
  font_size = true,
  opacity = true
}

local function get_value(computed, value)
  if value == "_parent" or value == "_source" then
    return nil
  end

  if computed._source[value] then
    return computed._source[value]
  end

  for _, v in ipairs(computed.styles) do
    if computed._flags.hover and v._hover_ and v._hover_[value] then
      return v._hover_[value]
    elseif v[value] then
      return v[value]
    end
  end

  if computed._parent and INHERITABLE[value] then
    return computed._parent[value]
  end
end

function styles.add(name, values)
  styles[name] = values
end

function styles.compute(source, parent_style, flags)
  local s = source.style
  local result = setmetatable({
    _source = source,
    _parent = parent_style,
    _flags = flags or {},
    styles = list:new() }, {
     __index = get_value
   })

   result.update_flags = function(f)
    result._flags = f or {}
   end

  if s then
    local style_list = str.split(s)
    for v in reverse(style_list) do
      result.styles:add(styles[v])
    end
  end

  if source.name and styles[source.name] then
    result.styles:add(styles[source.name])
  end

  return result
end

setmetatable(styles, {
  __call = styles.compute
})

return styles
