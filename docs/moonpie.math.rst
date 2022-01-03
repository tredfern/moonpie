moonpie.math 
============

A basic library for some math functions. 

Functions
---------

floor(...)
  Returns the floor value for a list of values. Useful for flooring return values from a function

moonpie.math.cards
------------------

Provides a basic implementation of a deck of cards with a Fisher-Yates shuffler to randomize the elements.

.. code-block:: lua

  local maths = require "moonpie.math"
  local deck = maths.cards.newDeck { 1, 2, 3, 4, 5, 6, 7, 8, 9 }
  deck:shuffle()
  local hand = deck:deal(3)
  -- hand == { 4, 9, 2 }
  -- deck == { 5, 1, 3, 7, 6, 8 }

moonpie.math.rectangle
----------------------

Provides a basic implementation for rectangles with additional helpers

new(x,y,width,height)
  Returns a new rectangle with the specified dimensions

left(self)
  Returns the leftmost coordinate (x)

right(self)
  Returns the rightmost coordinate (x+width)

top(self)
  Returns the topmost coordinate (y)

bottom(self)
  Returns the bottommost coordinate (y+height)

[true] intersects(self, rect)
  Returns true if the two rectangles intersects

[rect] overlap(self, rect)
  Returns a new rectangle that is the overlapping region between 2 rectangles

[x,y] center(self)
  Returns the coordinates in the middle of the rectangle