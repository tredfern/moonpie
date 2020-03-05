moonpie.collections
===================

Various collections and structures to help provide functionality to lua tables.

.. code-block:: lua

    local a_list = moonpie.collections.list:new()
    a_list:add("stuff", 1, 4, "more-stuff")
    if a_list:contains(4) then
      print "It does!"
    end


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

