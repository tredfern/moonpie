local lfs = require "lfs"
local screen_width, screen_height, flags = 1600, 900, { fullscreen = false }
local newFont = function()
  return {
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
end

local newImage = function()
  return setmetatable({
    width = 100,
    height = 100,
    getWidth = function(self) return self.width end,
    getHeight = function(self) return self.height end,
    getDimensions = function(self) return self:getWidth(), self:getHeight() end,
  }, { __newindex = function() error("Love does not allow this") end })
end

local newQuad = function(x, y, w, h, sw, sh)
  return {
    getViewport = function()
      return x, y, w, h
    end,
    getTextureDimensions = function()
      return sw, sh
    end
  }
end

local function newAudioClip()
  return setmetatable({
    _isPlaying = false, _isPaused = false, _isLooping = false,
    clone = function() return newAudioClip() end,
    isLooping = function(self) return self._isLooping end,
    isPaused = function(self) return self._isPaused end,
    isPlaying = function(self) return self._isPlaying end,
    pause = function(self) self._isPaused = true end,
    play = function(self) self._isPlaying = true end,
    seek = function() end,
    setLooping = function(self) self._isLooping = true end,
    setPitch = function() end,
    setVolume = function() end,
    stop = function(self) self._isPlaying = false end,
  }, { __newindex = function() error("Love does not allow this") end })
end

local newParticleSystem = function()
  return setmetatable({
    setColors = function() end,
    setEmissionArea = function() end,
    setEmissionRate = function() end,
    setLinearAcceleration = function() end,
    setParticleLifetime = function() end,
    setSizes = function() end,
    setSizeVariation = function() end,
    setTangentialAcceleration = function() end,

    update = function() end,

  }, { __newindex = function() error("Love does not allow this") end })
end

local newText = function()
  return {
    set = function() end,
    setf = function() end,
    getDimensions = function() return 10, 10 end
  }
end
local key_down = {}
local mouse_down = {}
local mouse_x, mouse_y = 0, 0

love = {
  audio = {
    newSource = function() return newAudioClip() end,
    play = function() end,
  },
  event = {
    quit = function() end,
  },
  getVersion = function() return 11 end,
  graphics = {
    getDimensions = function() return screen_width, screen_height end,
    getFont = function() return newFont() end,
    getHeight = function() return screen_height end,
    getStats = function() return { } end,
    getWidth = function() return screen_width end,
    line = function() end,
    newCanvas = function() return newImage() end,
    newFont = function() return newFont() end,
    newParticleSystem = function() return newParticleSystem() end,
    newQuad = newQuad,
    newImage = newImage,
    newText = function() return newText() end,
    origin = function() end,
    pop = function() end,
    print = function() end,
    push = function() end,
    rectangle = function(mode, x, y, w, h) end,
    reset = function() end,
    scale = function() end,
    setCanvas = function() end,
    setColor = function() end,
    setFont = function() end,
    setLineWidth = function() end,
    setScissor = function() end,
    translate = function() end,
},
filesystem = {
  getDirectoryItems = function(path)
    local results = { }

    for file in lfs.dir(path) do
      if file ~= "." and file ~= ".." then
        results[#results + 1] = file
      end
    end
    return results
  end,
  getInfo = function(path)
    local results = { }
    local attr = lfs.attributes(path)
    if attr then
      results.type = attr.mode
    else
      results = nil
    end
    return results
  end,
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
  math ={
    random = function(...) return math.random(...) end
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
    getTime = function() return os.clock() end
  },
  window = {
    getFullscreenModes = function()
      return {
        { width = 320, height = 240 },
        { width = 640, height = 480 },
        { width = 800, height = 600 },
      }
    end,
    getMode = function()
      return screen_width, screen_height, flags
    end,
    setMode = function(w, h, fs)
      screen_width, screen_height, flags = w, h, fs
    end
  },
  handlers = { }
}

local original_methods = {}
return {
  mock = function(tbl, method, replace)
    original_methods[tostring(tbl) .. method] = tbl[method]
    tbl[method] = replace
  end,
  reset = function(tbl, method)
    if original_methods[tostring(tbl) .. method] then
      tbl[method] = original_methods[tostring(tbl) .. method]
    end
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
  moveMouse = function(x, y)
    mouse_x, mouse_y = x, y
  end,
  reset_mouse = function()
    mouse_x, mouse_y = 0, 0
    mouse_down = {}
  end,
  reset_keyboard = function()
    key_down = {}
  end,
  newAudioClip = newAudioClip,
  newImage = newImage,
  newText = newText,
  newFont = newFont
}
