moonpie
=======

This is the entry point into the API and provides access to the rest of the framework. This eliminates the
need to require specific modules for operation of the framework. 

.. code-block:: lua

    moonpie = require "moonpie"

moonpie.class
^^^^^^^^^^^^^

This is sets up a metatable for a table that provides basic OOP functionality. It's not meant to be an overly
robust implementation as much as a lightweight overlay.

.. code-block:: lua

    local animal = moonpie.class({})
    function animal:constructor(name)
      self.name = name
    end
    
    local duck = animal:new("duck")
    print(duck.name)
