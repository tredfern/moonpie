moonpie.ecs
===========

The Moonpie Entity Component System is a lightweight approach to handling entities for processing.

.. code-block:: lua

    local moonpie = require "moonpie"
    local world = moonpie.ecs.world:new()

    world:add_systems(...)
    world:add_entities(...)
    world:update("some_method")
