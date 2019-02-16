-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local element_factory = {}

local function create_element(_base_, name, values)
  assert(type(name) == "string", "Element requires a name.")
  local t = values or {}
  t.name = name
  element_factory[name] = t

  setmetatable(t, {
    __index = _base_,
    __call = create_element
  })

  return t
end

local element = {
  on_hover = function(self, hover)
    self.hover = self(self.name .. ".hover", hover)
    return self
  end
}

setmetatable(element_factory, { __call =
  function(_, name, values)
    return create_element(element, name, values)
  end
})

element_factory("none", { display = "block" })
element_factory("root", { display = "block", width = love.graphics.getWidth(), height = love.graphics.getHeight() })

return element_factory
