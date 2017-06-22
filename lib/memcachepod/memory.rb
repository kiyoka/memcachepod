# frozen_string_literal: true

# encoding: ascii
module MemcachePod
  class Memory

    def initialize(max_memory)
      @max_memory = max_memory.to_i
      @memory_pool = Hash.new
    end

    def get(key, options=nil)
      remove_expires()
      if @memory_pool.has_key?(key)
        return @memory_pool[key].body
      else
        return nil
      end
    end

    def set(key, value, ttl=0, options=nil)
      remove_expires()
      if(@memory_pool.has_key?(key))
        @memory_pool[key].update(value,ttl)
      else
        @memory_pool[key] = MemoryEntry.new(value,ttl)
      end
    end

    def delete(key)
      if(@memory_pool.has_key?(key))
        @memory_pool.delete(key)
      end
    end

    def flush()
      @memory_pool = Hash.new
    end

    def get_status
      return @memory_pool.map {|k,v|
        v.get_status
      }
    end

    def get_memory_usage
      total = 0
      @memory_pool.map {|k,v|
        total += v.body.size
      }
      return total
    end
    
    private

    def remove_expires()
      @memory_pool.each_key{ |key|
        entry = @memory_pool[key]
        if entry.expired?
          @memory_pool.delete(key)
          #printf( "remove 1, key : %s \n", key )
        end
      }

      total = get_memory_usage

      @memory_pool.each_key{ |key|
        if @max_memory <= total
          entry = @memory_pool[key]
          total -= entry.body.size
          @memory_pool.delete(key)
          #printf( "remove 2, key : %s \n", key )
        else
          break
        end
      }

    end
  end
end

