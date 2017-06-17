# frozen_string_literal: true
$TESTING = true
require 'bundler/setup'
require 'logger'
require 'rspec'
require 'pp'
require 'simplecov'

SimpleCov.start
require 'memcachepod'

MemcachePod.logger = Logger.new(STDOUT)
MemcachePod.logger.level = Logger::ERROR
