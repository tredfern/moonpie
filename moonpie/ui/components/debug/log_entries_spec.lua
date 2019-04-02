-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Log Entries", function()
  require "moonpie.ui.components"
  local log_entries = require "moonpie.ui.components.debug.log_entries"
  local logger = require "moonpie.logger"

  before_each(function()
    logger.clear()
  end)

  it("creates a list of the log entries", function()
    logger.error("An error occurred.")
    local log = log_entries()
    local out = log:render()
    assert.matches("ERROR: An error occurred.", out[1][1].text)
  end)

  it("renders from newest to oldest", function()
    logger.info("Entry 1")
    logger.info("Entry 2")
    local log = log_entries()
    local out = log:render()
    assert.matches("INFO: Entry 2", out[1][1].text)
    assert.matches("INFO: Entry 1", out[2][1].text)
  end)
end)
