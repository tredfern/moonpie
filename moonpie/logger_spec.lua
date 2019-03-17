-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Logger", function()
  local logger = require "moonpie.logger"

  before_each(function()
    logger.clear()
  end)

  describe("basic log methods", function()
    it("can be cleared", function()
      logger.error("message")
      assert.equals(1, #logger.entries)
      logger.clear()
      assert.equals(0, #logger.entries)
    end)

    it("can log errors", function()
      logger.error("message")
      assert.equals("message", logger.entries[1].message)
    end)

    it("can log information", function()
      logger.info("info message")
      assert.equals("info message", logger.entries[1].message)
    end)

    it("can log debug", function()
      logger.debug("debug message")
      assert.equals("debug message", logger.entries[1].message)
    end)
  end)

  describe("log entries", function()
    it("tracks the error log level", function()
      logger.error("message")
      assert.not_nil(logger.entries[1].level)
      assert.equals(logger.level.error, logger.entries[1].level)
    end)

    it("tracks the info log level", function()
      logger.info("message")
      assert.not_nil(logger.entries[1].level)
      assert.equals(logger.level.info, logger.entries[1].level)
    end)

    it("tracks the debug log level", function()
      logger.debug("message")
      assert.not_nil(logger.entries[1].level)
      assert.equals(logger.level.debug, logger.entries[1].level)
    end)

    it("tracks the entry time", function()
      logger.debug("message")
      assert.not_nil(logger.entries[1].timestamp)
      assert.near(os.time(), logger.entries[1].timestamp, 1000)
    end)
  end)

  describe("maximum size", function()
    it("can limit the total log entries tracked", function()
      logger.max_entries = 10

      for i = 1,20 do
        logger.debug(string.format("message %d", i))
      end

      assert.equals(10, #logger.entries)
      assert.equals("message 11", logger.entries[1].message)
    end)
  end)

  describe("nice to haves", function()
    it("can log a function for tracking purposes", function()
      local f = spy.new(function(a) return a end)
      f = logger.track(f, "my_func")
      f(1, 2, 3)
      f("foo")
      assert.equals("Calling my_func(1, 2, 3)", logger.entries[1].message)
      assert.equals("Returning my_func = 1", logger.entries[2].message)
      assert.equals("Calling my_func(foo)", logger.entries[3].message)
      assert.equals("Returning my_func = foo", logger.entries[4].message)
    end)
  end)
end)
