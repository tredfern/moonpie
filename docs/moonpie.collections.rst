moonpie.collections
===================

Various collections and structures to help provide functionality to lua tables.

.. code-block:: lua

    local a_list = moonpie.collections.list:new()
    a_list:add("stuff", 1, 4, "more-stuff")
    if a_list:contains(4) then
      print "It does!"
    end