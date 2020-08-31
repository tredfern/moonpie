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


moonpie.event_system
^^^^^^^^^^^^^^^^^^^^

A simple mechanism for creating loosely coupled components that can dispatch events. Events are registered onto the 
system to be handled. Subscribers can register to specific events. Those events can then be dispatched to with 
additional arguments as necessary.

Event messages are formatted the same as actions to the state management store. This keeps things consistent but
allows for different purposes for dispatching.

.. code-block:: lua

  local my_callback_function = function(data)
    print(data.payload)
  end

  local events = require "moonpie.event_system"
  events.register("hello")
  events.subscribe("hello", my_callback_function)
  events.dispatch( { type = "hello", payload = "extra_data" })
