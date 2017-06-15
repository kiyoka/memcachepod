# frozen_string_literal: true

require 'memcachepod/memory_entry'
require 'memcachepod/memory'
require 'memcachepod/client'

module MemcachePod

  def self.logger
    @logger = default_logger
  end
  
  def self.default_logger
    require 'logger'
    logger = Logger.new(STDOUT)
    logger.level = Logger::INFO
    logger
  end

  def self.logger=(logger)
    @logger = logger
  end

end
