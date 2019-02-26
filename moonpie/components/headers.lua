-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local Component = require(BASE .. "component")

Component("header", {
  color = "primary"
})

Component.header("header1", {
  margin = 10 
})

Component.header("header2", {
  margin = { left = 10, right = 10, top = 7, bottom = 7 }
})
Component.header("header3", {
  margin = { left = 10, right = 10, top = 5, bottom = 5 }
})
