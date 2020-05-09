moonpie.events
==============

Events are triggered at various times during interactions with
Love2d. These are designed to provide a way of looping in components
and behaviors to certain timings without relying on a difficult
to maintain call sequence.

Love2D is the ultimate trigger source for events and these do
need to be passed manually into Moonpie. This allows the most
control possible for engineering solutions while keeping code
upstream clean.

Available Events
----------------

.. code-block:: lua

  local function my_callback()
    print("called")
  end

  moonpie.events.before_update:add(my_callback)
  
  function love.update()
    moonpie.update()
  end

  -- Output
    called