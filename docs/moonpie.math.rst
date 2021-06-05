moonpie.math 
============

A basic library for some math functions. 


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
