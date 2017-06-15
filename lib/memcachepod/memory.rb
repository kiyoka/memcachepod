# frozen_string_literal: true

# encoding: ascii
module MemcachePod
  class Memory

    def initialize()
      @size = 1024*1024 # bytes
      @memory_pool = Hash.new
    end

    def get(key, options=nil)
      if(@memory_pool.has_key?(key))
        return @memory_pool[key].body
      else
        return nil
      end
      remove_expires()
    end

    def set(key, value, ttl, options=nil)
      if(@memory_pool.has_key?(key))
        @memory_pool[key].update(value,ttl)
      else
        @memory_pool[key] = MemoryEntry.new(value,ttl)
      end
    end

    def flush()
      @memory_pool = Hash.new
    end

    def get_status
      return @memory_pool.map {|entry|
        entry.get_status
      }
    end
    
    private

    def remove_expires()
      @memory_pool.each_key{ |key|
        entry = @memory_pool[key]
        if not entry.reference?()
          if entry.expired?
            @memory_pool.delete(key)
          end
        end
      }
    end
    
  end
end

