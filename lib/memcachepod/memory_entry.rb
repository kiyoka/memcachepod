# frozen_string_literal: true

require 'date'

# encoding: ascii
module MemcachePod
  class MemoryEntry

    attr_reader :body

    def initialize(body,ttl)
      @reference = false
      @body = body
      @expires_in = expires_in(ttl)
    end

    def update(body,ttl)
      @body = body
      @expires_in = expires_in(ttl)
    end

    def referenced()
      @reference = true
    end

    def reference?()
      return @refernece
    end

    def expire?()
      now = Time.now.to_i #second
      return @expires_in < now
    end

    def get_status
      return [
        'reference' => @refernece,
        'expires_in' => @expires_in - Time.now.to_i,
        'bodysize' => @body.size
      ]
    end

    private
    
    def expires_in(ttl)
      now = Time.now.to_i #second
      return now + ttl
    end

  end
end

