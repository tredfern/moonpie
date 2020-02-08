-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local logger = {}
local list = require "moonpie.collections.list"
logger.entries = list:new()
logger.level = {
  error = "ERROR",
  info = "INFO",
  debug = "DEBUG"
}
logger.max_entries = 10000

function logger.add_entry(level, msg)
  logger.entries:add({
    timestamp = os.time(),
    level = level,
    message = msg
  })
  logger.trim()
end

function logger.error(msg)
  logger.add_entry(logger.level.error, msg)
end

function logger.info(msg)
  logger.add_entry(logger.level.info, msg)
end

function logger.debug(msg)
  logger.add_entry(logger.level.debug, msg)
end


function logger.clear()
  logger.entries = list:new()
end

function logger.trim()
  if logger.max_entries and #logger.entries > logger.max_entries then
    logger.entries = logger.entries:last(logger.max_entries)
  end
end

function logger.track(f, name)
  return function(...)
    local m = table.concat({...}, ", ")
    logger.debug("Calling " .. name .. "(" .. m .. ")")
    local out1 = f(...)
    logger.debug("Returning " .. name .." = " .. tostring(out1))
    return out1
  end
end

function logger.dump_table(tbl, name)
  name = name or "table"
  local str = name .. ": {"
  for k, v in pairs(tbl) do
    str = str .. " "
    if type(v) == "number" then
      str = str .. string.format("%s=%d", k, v)
    end
    if type(v) == "string" then
      str = str .. string.format('%s="%s"', k, v)
    end
  end
  str = str .. " }"
  logger.debug(str)
end

return logger
