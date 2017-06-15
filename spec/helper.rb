# frozen_string_literal: true
$TESTING = true
require 'bundler/setup'
require 'memcachepod'
require 'logger'
require 'rspec'

MemcachePod.logger = Logger.new(STDOUT)
MemcachePod.logger.level = Logger::ERROR
