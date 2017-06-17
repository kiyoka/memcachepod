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

    def expired?()
      if 0 < @expires_in
        now = Time.now.to_i #second
        return @expires_in < now
      else
        return false
      end
    end

    def get_status
      exp = 0
      if 0 < @expires_in
        exp = @expires_in - Time.now.to_i
      end
      return [
        'reference'  => @refernece,
        'expires_in' => exp,
        'bodysize'   => @body.size
      ]
    end

    private
    
    def expires_in(ttl)
      if 0 < ttl
        now = Time.now.to_i #second
        return now + ttl
      end
      return 0
    end

  end
end

