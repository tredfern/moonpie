-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
--
-- Test/Demo for Moonpie
--

local moonpie = require "moonpie"
local components = moonpie.components
local lorem = love.filesystem.read("lorem_ipsum.txt")
local show_light = true
local current_layout = 1
local layouts

local function update_layout()
  local lt = components.section({
    padding = 5,
    layouts[current_layout]()
  })
  moonpie.layout(lt)
end

function love.load()
  update_layout()
end

function love.update()
  moonpie.update()
end

function love.draw()
  moonpie.paint()
end

local function next_demo_button()
  return components.button({
    style = "button_primary",
    caption = "Next Demo",
    click = function()
      current_layout = current_layout + 1
      update_layout()
    end
  })
end

local function switch_mode_button()
  return components.button({
    caption = "Switch Mode",
    click = function()
      if show_light then
        moonpie.themes.dark_mode(moonpie)
      else
        moonpie.themes.light_mode(moonpie)
      end
      show_light = not show_light
    end
  })
end


local function header(props)
  return {
    components.section({
      components.h1({ text = "Moonpie for Love2D" }),
      components.button_group({
        style = "align-right",
        buttons = {
          next_demo_button(),
          switch_mode_button()
        }
      })
    }),
    components.section({
      components.h3({ text = props }),
    }),
  }
end

local function text_layout()
  return {
    header("Long Text Demo"),
    components.section({
      components.text({ text = lorem, padding = 5 }),
    })
  }
end

local function button_layout()
  return {
    header("Buttons"),
    {
      margin = 5,
      components.button({ caption = "Default" }),
      components.button({ style = "button_primary", caption = "Primary" }),
      components.button({ style = "button_info", caption = "Info" }),
      components.button({ style = "button_warning", caption = "Warning" }),
      components.button({ style = "button_success", caption = "Success" }),
      components.button({ style = "button_danger", caption = "Danger" }),
    },
    {
      margin = 5,
      components.button({ style = "button_small", caption = "Default" }),
      components.button({ style = "button_primary button_small", caption = "Primary" }),
      components.button({ style = "button_info button_small", caption = "Info" }),
      components.button({ style = "button_warning button_small", caption = "Warning" }),
      components.button({ style = "button_success button_small", caption = "Success" }),
      components.button({ style = "button_danger button_small", caption = "Danger" }),
    }
  }
end

local function image_layout()
  return {
    header("Images"),
    components.section({
      components.image({ src = "assets/images/cat.jpg" }),
      components.image({ src = "assets/images/small.jpg",  width = 200, height = 200 }),
      components.image({ src = "assets/images/big.jpg", width = 300, height = 150 }),
    }),
  }
end

local function color_gradient(base_color, gradients)
  local t = {}
  for i = 1, gradients do
    t[i] = components.text({ padding = 10, text = tostring(i),
      background_color = moonpie.colors.lighten(base_color, 1 + ( i / 10))
    })
  end
  return t
end

local function pulsing_color()
  local function make_color_change(time, v, e)
    local clr = v
    local ctween = moonpie.tween.new(time, clr, e)

    return function()
      ctween:update(love.timer.getDelta())
      return v
    end
  end

  return {
    header("Colors!"),
    components.section({
      components.text({ padding = 10, text = "Black to Cyan",
        background_color = make_color_change(5, moonpie.colors.black, moonpie.colors.cyan) }),
      components.text({ padding = 10, text = "Red to Gray",
        background_color = make_color_change(10, moonpie.colors.red, moonpie.colors.gray) }),
    }),
    components.h3({ text = "Lighten the things" }),
    components.section({
      color_gradient(moonpie.colors.dark_lava, 20),
      color_gradient(moonpie.colors.purple, 20),
      color_gradient(moonpie.colors.avocado, 20),
    })
  }
end


layouts = {
  text_layout,
  button_layout,
  image_layout,
  pulsing_color
}
