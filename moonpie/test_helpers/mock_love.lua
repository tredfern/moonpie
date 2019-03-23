local font = {
  getWidth = function() return 10 end,
  getHeight = function() return 10 end,
  getWrap = function(_, text) 
    local t={}
    for str in string.gmatch(text, "([^:]+)") do
      table.insert(t, str)
    end
    return 10, t
  end
}

local image = setmetatable({
  width = 100,
  height = 100,
  getWidth = function(self) return self.width end,
  getHeight = function(self) return self.height end,
  getDimensions = function(self) return self:getWidth(), self:getHeight() end,
}, { __newindex = function() error("Love does not allow this") end })

local text = {
  setf = function() end,
  getDimensions = function() return 10, 10 end
}
local key_down = {}
local mouse_down = {}
local mouse_x, mouse_y = 0, 0

love = {
    event = {
      quit = function() end,
    },
    getVersion = function() return 11 end,
    graphics = {
        getFont = function() return font end,
        getHeight = function() return 900 end,
        getStats = function() return { } end,
        getWidth = function() return 1600 end,
        newCanvas = function() return image end,
        newFont = function() return font end,
        newQuad = function() return { } end,
        newImage = function() return image end,
        newText = function() return setmetatable({}, { __index = text }) end,
        origin = function() end,
        pop = function() end,
        print = function() end,
        push = function() end,
        rectangle = function(mode, x, y, w, h) end,
        reset = function() end,
        setCanvas = function() end,
        setColor = function() end,
        setFont = function() end,
        setScissor = function() end,
        translate = function() end,
    },
    filesystem = {
        read = function(path)
            local file = io.open(path, "rb") -- r read mode and b binary mode
            if not file then return nil end
            local content = file:read "*a" -- *a or *all reads the whole file
            file:close()
            return content
        end
    },
    keyboard = {
      isDown = function(key)
        return key_down[key] ~= nil
      end
    },
    mouse = {
      getPosition = function()
        return mouse_x, mouse_y
      end,
      isDown = function(button)
        return mouse_down[button] ~= nil
      end,
    },
    timer = {
      getDelta = function() return 0.03 end,
      getFPS = function() return 29 end,
      getTime = function() return os.time() end
    },
    handlers = { }
}
return {
  mock = function(tbl, method, replace)
    tbl[method] = replace
  end,
  override_graphics = function(v, r)
    love.graphics[v] = r
  end,
  simulate_key_down = function(key)
    key_down[key] = true
  end,
  simulate_key_up = function(key)
    key_down[key] = nil
  end,
  simulate_button_down = function(button)
    mouse_down[button] = true
  end,
  simulate_button_up = function(button)
    mouse_down[button] = nil
  end,
  move_mouse = function(x, y)
    mouse_x, mouse_y = x, y
  end,
  reset_mouse = function()
    mouse_x, mouse_y = 0, 0
    mouse_down = {}
  end,
  font = font,
  image = image,
  text = text
}
