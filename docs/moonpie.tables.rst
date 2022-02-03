moonpie.tables
==============

The tables utilities provides various mini-functions for helpful operations.

tables.count(set, func)
  Returns the count of items that match the comparison function passed in.

.. code-block:: lua

  local set = { 1, 2, 3, 4, 5, 6 }
  local compare = function(v) return v % 2 == 0 end

  print(tables.count(set, compare))
  -- 3


tables.deepCompare(tbl1, tbl2, ignoreMT)
  Tests the values in the the 2 tables to see if they look the same without having to be the same table instance.

tables.keysToList(tbl)
  Returns a table in array form where all the entries from tbl are outputted into a list formats.

tables.popRandom(list)
  Selects a random item out of the list, removes it and returns the selected item.

tables.slice(list, start, [end])
  Returns a slice of the elements from the array. If end is not provided, defaults to end of array. 
  If a negative number is passed into start, it takes from the end of the array.

tables.swap(tbl, i, j)
  Swaps two elements positions in the table

tables.take(tbl, count)
  Takes the specified count of elements from the front of the table. Because of the reshuffle of the table performance
  is not optimal for many operations during critical cycles.

tables.toString(tbl)
  Outputs a human readable form of the table. Useful for debugging purposes.

tables.unpack(tbl)
  The Lua unpack routine provided by the library but because sometimes it's based on table and sometimes global
  this just simplifies tracking it.