-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local copy_props = {
  "background_color",
  "height",
  "padding",
  "style",
  "width"
}

local component_factory = {}

local function create_component(name, generator)
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

setmetatable(component_factory, { __call =
  function(_, name, generator)
    return create_component(name, generator)
  end
})

return component_factory
