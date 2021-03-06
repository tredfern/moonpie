-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local str = require "moonpie.utility.string"
local reverse = require "moonpie.collections.iterators.reverse"

local styles = {}

local INHERITABLE = {
  color = true,
  font = true,
  fontName = true,
  fontSize = true,
  opacity = true
}

local function getValue(computed, value)
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

function styles.compute(source, parentStyle, flags)
  local s = source.style
  local result = setmetatable({
    _source = source,
    _parent = parentStyle,
    _flags = flags or {},
    styles = {} }, {
     __index = getValue
   })

   result.updateFlags = function(f)
    result._flags = f or {}
   end

  if s then
    local style_list = str.split(s)
    for v in reverse(style_list) do
      table.insert(result.styles, styles[v])
    end
  end

  if source.name and styles[source.name] then
    table.insert(result.styles, styles[source.name])
  end

  return result
end

setmetatable(styles, {
  __call = styles.compute
})

return styles
