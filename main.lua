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

local function header(props)
  return {
    components.section({
      components.h1({ text = "Moonpie for Love2D" }),
      components.button_group({
        style = "align-right",
        buttons = {
          components.button({
            style = "button_primary",
            caption = "Next Demo",
            click = function()
              current_layout = current_layout + 1
              update_layout()
            end
          }),
          components.button({
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
      components.button_group({
        margin = 5,
        buttons = {
          components.button({ caption = "Default" }),
          components.button({ style = "button_primary", caption = "Primary" }),
          components.button({ style = "button_info", caption = "Info" }),
          components.button({ style = "button_warning", caption = "Warning" }),
          components.button({ style = "button_success", caption = "Success" }),
          components.button({ style = "button_danger", caption = "Danger" }),
        }
      }),
    },
    {
      components.button_group({
        margin = 5,
        buttons = {
          components.button({ style = "button_small", caption = "Default" }),
          components.button({ style = "button_primary button_small", caption = "Primary" }),
          components.button({ style = "button_info button_small", caption = "Info" }),
          components.button({ style = "button_warning button_small", caption = "Warning" }),
          components.button({ style = "button_success button_small", caption = "Success" }),
          components.button({ style = "button_danger button_small", caption = "Danger" }),
        }
      }),
    }
  }
end

local function image_layout()
  return {
    header("Images"),
    components.section({
      components.h3({ text = "Just an image" }),
      components.image({ src = "assets/images/cat.jpg" }),
    }),
    components.section({
      components.h3({ text = "Stretch it" }),
      components.image({ src = "assets/images/small.jpg",  width = 200, height = 200, scaling = "fit" }),
    }),
    components.section({
      components.h3({ text = "Shrink it" }),
      components.image({ src = "assets/images/big.jpg", width = 200, heigth = 200, scaling = "fit" }),
    })
  }
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
      components.text({ padding = 10, text = "0", background_color = moonpie.colors.lighten(moonpie.colors.dark_lava, 1.0) }),
      components.text({ padding = 10, text = "1", background_color = moonpie.colors.lighten(moonpie.colors.dark_lava, 1.1) }),
      components.text({ padding = 10, text = "2", background_color = moonpie.colors.lighten(moonpie.colors.dark_lava, 1.2) }),
      components.text({ padding = 10, text = "3", background_color = moonpie.colors.lighten(moonpie.colors.dark_lava, 1.3) }),
      components.text({ padding = 10, text = "4", background_color = moonpie.colors.lighten(moonpie.colors.dark_lava, 1.4) }),
      components.text({ padding = 10, text = "5", background_color = moonpie.colors.lighten(moonpie.colors.dark_lava, 1.5) }),
      components.text({ padding = 10, text = "6", background_color = moonpie.colors.lighten(moonpie.colors.dark_lava, 1.6) }),
      components.text({ padding = 10, text = "7", background_color = moonpie.colors.lighten(moonpie.colors.dark_lava, 1.7) }),
      components.text({ padding = 10, text = "8", background_color = moonpie.colors.lighten(moonpie.colors.dark_lava, 1.8) }),
      components.text({ padding = 10, text = "9", background_color = moonpie.colors.lighten(moonpie.colors.dark_lava, 1.9) }),
      components.text({ padding = 10, text = "10", background_color = moonpie.colors.lighten(moonpie.colors.dark_lava, 2.0) }),
      components.text({ padding = 10, text = "11", background_color = moonpie.colors.lighten(moonpie.colors.dark_lava, 2.1) }),
    })
  }
end

layouts = {
  text_layout,
  button_layout,
  image_layout,
  pulsing_color
}
