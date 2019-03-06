-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local copy_props = {
  "style"
}

local component_factory = {}

local function create_next_name(name)
  local i = 1
  while component_factory[name..tostring(i)] ~= nil do
    i = i + 1
  end
  return name..tostring(i)
end

local function new_create_component(name, generator)

  component_factory[name] = function(props)
    props = props or {}
    local c = generator(props)
    c.name = name
    for _, v in ipairs(copy_props) do
      if props[v] then c[v] = props[v] end
    end
    return c
  end

end

local function create_component(_base_, name, values)
  if type(values) == "function" then
    return new_create_component(name, values)
  end

  if type(name) == "table" then
    values = name
    name = create_next_name(_base_.name)
  end

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
  modify = function(self, values)
    for k, v in pairs(values) do
      self[k] = v
    end
    self.refresh_layout = true
  end,
  children = function(self)
    return ipairs(self)
  end,
  on_hover = function(self, hover)
    self.hover = self(self.name .. ".hover", hover)
    return self
  end,
  on_click = function(self, callback)
    self.click = function()
      callback(self)
    end
    return self
  end
}

setmetatable(component_factory, { __call =
  function(_, name, values)
    return create_component(component, name, values)
  end
})

return component_factory
