-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local element = {}

local function create_element(_base_, name, values)
  local t = values or {}
  t.name = name
  element[name] = t

  setmetatable(t, {
    __index = _base_,
    __call = create_element
  })

  return t
end

setmetatable(element, { __call =
  function(_, name, values)
    return create_element({}, name, values)
  end
})

element("none", { display = "block" })
element("root", { display = "block", width = love.graphics.getWidth(), height = love.graphics.getHeight() })

return element
