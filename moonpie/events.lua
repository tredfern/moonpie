-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local callback = require "moonpie.callback"
return {
  beforePaint = callback:new(),
  afterPaint = callback:new(),
  beforeUpdate = callback:new(),
  afterUpdate = callback:new(),
  windowResize = callback:new(),
}