moonpie.utility
===============


ensureKey(tbl, key, default)
  Makes sure that a table contains a key with a default value. Useful for state management in the store to make sure
  that values exist

isCallable(val)
  Returns true if the parameter is either a function or a table with a metatable that implements __call.

.. code-block:: lua

  local utility = require "moonpie.utility"
  utility.isCallable(function() end) -- true
  utility.isCallable({}) -- false
  utility.isCallable(setmetatable({}, { __call = function() end })) -- true

swapFunction(tbl, functionName, override)
  Replaces a table function with a new routine. This is most useful for testing scenarios to mock an API. ``:revert()``
  can be used to unwind the swapped function.

.. code-block:: lua

  local utility = require "moonpie.utility
  local tbl = { f = function() end }
  local new = function() end
  utility.swapFunction(tbl, "f", new)
  tbl:f() -- calls new(tbl)