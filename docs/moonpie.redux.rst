moonpie.redux
=============

An implementation of a concept similar to redux that is used in react and javascript implementations.
This provides a store that can be configured with reducers that handle state. Actions can be dispatched
to set up changing the the status of state.


Add Action Validator
--------------------

A helper to append validations to actions. Sometimes there is value in reusing previous existing actions, but
providing an additional method to validate the action.



Binding Components
------------------

A common issue is to bind components to state changes to refresh or respond to updated data. Sometimes components
are not designed from the ground up to be connected to the store. Binding allows taking advantage of dynamic
updates from the store to refresh the component.

.. code-block:: lua

  local Components = require "moonpie.ui.components"
  local c = bind(
    Components.text { text = "My Name" }, -- The created component to bind
    function(component, state) -- the binding routine
      -- Any logic and behavior could be applied here
      component:update { text = state.name }
    end)

    .
    .

    store.dispatch({ updateName = "foobar" })