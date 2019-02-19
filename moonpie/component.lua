-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local component_factory = {}

local function create_component(_base_, name, values)
  assert(type(name) == "string", "Component requires a name.")
  local t = values or {}
  t.name = name
  component_factory[name] = t

  setmetatable(t, {
    __index = _base_,
    __call = create_component
  })

  return t
end

local component = {
  on_hover = function(self, hover)
    self.hover = self(self.name .. ".hover", hover)
    return self
  end
}

setmetatable(component_factory, { __call =
  function(_, name, values)
    return create_component(component, name, values)
  end
})

component_factory("none", { display = "block" })
component_factory("root", { display = "block", width = love.graphics.getWidth(), height = love.graphics.getHeight() })

return component_factory
