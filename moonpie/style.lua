-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local style = {}

function style.customize(base, custom)
  custom.name = base.name .. ".custom"
  return setmetatable(custom, {
    __index = base
  })
end

setmetatable(style, {
  __call = function(_, name, values, base)
    local t = values or {}
    t.name = name
    style[name] = t

    setmetatable(t, { __index = base or style })

    return t
  end
})

style("none", { display = "block" })
style("root", { display = "block", width = love.graphics.getWidth(), height = love.graphics.getHeight() })

return style
