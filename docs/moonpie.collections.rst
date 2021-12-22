moonpie.collections
===================

Various collections and structures to help provide functionality to lua tables.

.. code-block:: lua

    local a_list = moonpie.collections.list:new()
    a_list:add("stuff", 1, 4, "more-stuff")
    if a_list:contains(4) then
      print "It does!"
    end

Grid
----

Provides a 2D array element that makes it easier to track and assign elements for 2D lists.
Initialized to a specific size and can handle default values when the value has not been set.

.. code-block:: lua

  local Grid = require "moonpie.collections.grid"
  local g = Grid:new(10, 10, "default")
  g:set(3, 2, "hello")
  print(g:get(3, 2)) -- "hello"
  print(g:get(8, 2)) -- "default"

Properties & Methods
`````````````````````

default
  The default returned if the location requested is empty

get(x, y)
  Retrieves the value at the specified location. If empty, return default or nil

height
  The height of the grid data

set(x, y, value)
  Sets the value at the specified location, overriding any previous value assigned there.

width
  The width of the grid data



moonpie.collections.iterators
-----------------------------

Iterators provide a variety of functions for iterating over tables. They should work with any index based table.

moonpie.collections.iterators.cycle
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The cycle iterator allows continuous looping over an array. It also provides the ability to move backwards
through the list.

moonpie.collections.iterators.cycle(array_table, count)
array_table = any table with an index list
count = the limit of cycles to perform

.. code-block:: lua

  local set = { 1, 2, 3, 4 }
  
  for value, index in moonpie.collections.iterators.cycle(set, 2) do
    print(value)
  end

  --
  -- Output:
  --
  -- 1
  -- 2
  -- 3
  -- 4
  -- 1
  -- 2
  -- 3
  -- 4


.. code-block:: lua

  local set = { 1, 2, 3, 4 }
  local cycle_iter = moonpie.collections.iterators.cycle(set)
  print(cycle_iter.previous()) -- Output: 4
  print(cycle_iter.previous()) -- Output: 3

