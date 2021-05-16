moonpie.test_helpers
====================

Test helpers and extra assertions are provided for the Busted <http://olivinelabs.com/busted/> testing framework.


Array Extensions
~~~~~~~~~~~~~~~~

A number of array helpers are available:

.. code-block:: lua

  it("has some array elements", function()
    local test = { 1, 2, 3, 4 }
    assert.array_includes(1, test)
  end)


Component Extensions
~~~~~~~~~~~~~~~~~~~~

.. code-block:: lua

  -- Code to test
  local components = require "moonpie.ui.components"
  local my_comp = components("my_comp", function()
    return {
      components.text(),
      components.text { id = "12345" }
    }
  end)

  it("contains a component", function()
    assert.contains_component("text", my_comp())
  end)

  it("contains a component with id", function()
    assert.contains_component_with_id("12345", my_comp())
  end)

Matchers
^^^^^^^^
Matchers are used when validating arguments to spies.

matches.in_range(low, high)
  Returns true if the value is in the range specified. Automatically sorts the low/high values by size when passed in.


Mock Store
^^^^^^^^^^

Mocks the redux style store that manages state. Allowing easier testing of components that are dependent on the store.

.. code-block:: lua

  describe("My test harness", function()
    local mock_store = require "moonpie.test_helpers.mock_store"
    local initial_state = { values = true }
    local store = mock_store(initial_state)

    it("can track dispatches", function()
      system_under_test.do_thing_that_dispatches()
      assert.equals(1, #store.get_actions("action_type"))
    end)
  end)


General helpers
^^^^^^^^^^^^^^^

spy_to_func
  Converts a spy routine into a pure function. This can be helpful in situations where the code under test responds 
  differently to tables vs functions.