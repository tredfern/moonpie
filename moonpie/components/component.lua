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

local function create_component(name, render)
  component_factory[name] = function(props)
    props = props or {}
    local c = render(props)
    c.name = name

    for _, v in ipairs(copy_props) do
      if props[v] then c[v] = props[v] end
    end
    return c
  end

end

setmetatable(component_factory, { __call =
  function(_, name, render)
    return create_component(name, render)
  end
})

return component_factory
