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