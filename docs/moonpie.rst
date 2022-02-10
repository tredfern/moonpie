moonpie
=======

This is the entry point into the API and provides access to the rest of the framework. This eliminates the
need to require specific modules for operation of the framework. 

.. code-block:: lua

    moonpie = require "moonpie"

moonpie.class
^^^^^^^^^^^^^

Utilized the middleclass library for functionality: 
https://github.com/kikito/middleclass


moonpie.keyboard
^^^^^^^^^^^^^^^^

Provides access to keyboard routines, including the ability to configure hotkeys that will trigger a function.

.. code-block:: lua

    local keyboard = require "moonpie.keyboard"
    keyboard:hotkey("a", function() print("Pressed A") end)
    keyboard:hotkey("shift+a", function() print("Pressed shift(either)+a") end)
    Keyboard:hotkey("alt+ctrl+shift+8", function() print("alt, ctrl, shift, 8 ... all at the same time") end)

hotkey(keycode, function)
  Maps a function that will be triggered on keypress. Only one function can be mapped to the callback.
  _keycode_ can be formatted with context keys separated by a plus: alt, ctrl, shift **In that order**
  Examples: "a", "ctrl+a", "ctrl+shift+a", "alt+a"


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
