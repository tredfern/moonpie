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