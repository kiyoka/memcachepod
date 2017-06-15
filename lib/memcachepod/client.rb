# frozen_string_literal: true

# encoding: ascii
module MemcachePod
  class Client

    ##
    # MemcachePod::Client is the main class which developers will use to interact with.
    #
    # MemcachePod::Client.new(['localhost:11211:10', 'cache-2:11211:5']
    #                          ,threadsafe => true, :expires_in => 300)
    #
    # This class aims to keep compatiblity ather memcache client.
    #
    def initialize(servers=nil, options={})
      # servers is dummy argument
      @options = Hash.new
      if options[:expires_in]
        @options[:expires_in] = options[:expires_in]
      end
      if options[:threadsafe]
        @options[:threadsafe] = options[:threadsafe]
      end
      if options[:namespace]
        @options[:namespace]  = options[:namespace]
      end

      @memory = Memory.new
    end

    def get(key, options=nil)
      key = validate_key(key)
      return @memory.get(key, options)
    end

    def set(key, value, ttl=nil, options=nil)
      key = validate_key(key)
      ttl = ttl_or_default(ttl)
      @memory.set(key, value, ttl, options)
    end

    def add(key, value, ttl=nil, options=nil)
      raise NotImplementedError.new("not implemented add()")
    end

    def replace(key, value, ttl=nil, options=nil)
      raise NotImplementedError.new("not implemented replace()")
    end

    def delete(key)
      raise NotImplementedError.new("not implemented delete()")
    end

    def append(key, value)
      raise NotImplementedError.new("not implemented append()")
    end

    def prepend(key, value)
      raise NotImplementedError.new("not implemented prepend()")
    end

    def flush(delay=0)
      @memory.flush()
    end

    def get_status
      return @memory.get_status
    end

    alias_method :flush_all, :flush

    private

    def validate_key(key)
      raise ArgumentError, "key cannot be blank" if !key || key.length == 0
      key = key_with_namespace(key)
      return key
    end

    def key_with_namespace(key)
      # TODO: implement namespace
      return key
    end
    
    def ttl_or_default(ttl)
      if ttl
        ttl
      elsif @options.has_key?(:expires_in)
        @options[:expires_in].to_i
      else
        0
      end
    end
    
  end
end
