# frozen_string_literal: true

require_relative 'helper'

describe 'Basic' do
  before do
    @pod = MemcachePod::Client.new(["localhost:11211"])
  end
  
  describe 'key validation' do
    it "should" do
      @pod.set('   ', 1)
      expect(@pod.get('   ')).to                 eq(1)
      @pod.set("\t", 1)
      expect(@pod.get("\t")).to                  eq(1)
      @pod.set("\n", 1)
      expect(@pod.get("\n")).to                  eq(1)
      expect{@pod.set("", 1)}.to                 raise_error(ArgumentError)
      expect{@pod.get("")}.to                    raise_error(ArgumentError)
    end
  end

  describe 'using basic memcache api' do
    before do
      @pod  = MemcachePod::Client.new(["localhost:11211"])
      @val1 = "1234567890"*105000
      @val2 = "1234567890"*100000
    end

    it "should" do
      @pod.flush
      @pod.set('a',@val1)
      expect(@pod.get('a')).to                  eq(@val1)
      @pod.set('b',@val2)
      expect(@pod.get('b')).to                  eq(@val2)
      expect(@pod.get('c')).to be               nil
      @pod.flush
      expect(@pod.get('a')).to be               nil      
      expect(@pod.get('b')).to be               nil      
      expect(@pod.get('c')).to be               nil      
    end
  end
end

