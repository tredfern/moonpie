moonpie.graphics
================


moonpie.graphics.colors
-----------------------

Provides access to a color library with hundreds of default colors. Also allows for certain functionality
such as lightening colors or making gradients.


moonpie.graphics.font
---------------------

Manages fonts making it easy to load and reuse font resources. Fonts can be referenced by a name that makes it
easy to switch out the font without impacting code or ui elements.


.. code-block:: lua

  local Font = require "moonpie.graphics.font"
  Font:register("assets/fonts/my_font.ttf", "title")
  local f = Font:get("title")
  local text = love.graphics.newText(f, "Hello World")
  love.graphics.draw(text, 20, 20)

moonpie.graphics.image
----------------------

Provides functionality to access and manage images in a way that limits creating duplicate copies

*moonpie.graphics.image.load(path)*

