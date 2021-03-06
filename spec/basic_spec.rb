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
      expect(@pod.version['localhost']).to      eq(MemcachePod::VERSION)
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

  describe 'using ttl' do
    before do
      @pod  = MemcachePod::Client.new(["localhost:11211"])
      @val1 = "val1"
      @val2 = "val2"
      @val3 = "val3"
      @val4 = "val4"
    end

    it "should" do
      @pod.set('2',@val1,2)
      expect(@pod.get('2')).to                  eq(@val1)
      @pod.set('5',@val2,5)
      expect(@pod.get('5')).to                  eq(@val2)
      @pod.set('7',@val3,7)
      expect(@pod.get('7')).to                  eq(@val3)
      expect(@pod.get('7')).to                  eq(@val3)
      @pod.set('0',@val4)
      expect(@pod.get('0')).to                  eq(@val4)

      sleep(3.0)
      expect(@pod.get('2')).to be               nil
      expect(@pod.get('5')).to                  eq(@val2)
      sleep(3.0)
      expect(@pod.get('2')).to be               nil
      expect(@pod.get('5')).to be               nil
      expect(@pod.get('7')).to                  eq(@val3)
      expect(@pod.get('A')).to be               nil
      expect(@pod.get('B')).to be               nil
      expect(@pod.get('C')).to be               nil
      sleep(5.0)
      expect(@pod.get('0')).to                  eq(@val4)
    end
  end

  describe 'updating data' do
    before do
      @pod  = MemcachePod::Client.new(["localhost:11211"])
      @val1 = "val1"
    end

    it "should" do
      @pod.set('2',@val1)
      expect(@pod.get('2')).to                  eq(@val1)
      sleep(3.0)
      expect(@pod.get('2')).to                  eq(@val1) # never expire

      @pod.set('2',@val1, 2)
      expect(@pod.get('2')).to                  eq(@val1)
      sleep(3.0)
      expect(@pod.get('2')).to be               nil       # expired in 3 sec.
    end
  end

  describe 'get_status' do
    before do
      @pod  = MemcachePod::Client.new(["localhost:11211"])
      @val1 = "val1"
      @val2 = "val2"
      @val3 = "val3"
      @val4 = "val4"
    end

    it "should" do
      @pod.set('1',@val1,1)
      @pod.set('2',@val2,2)
      expect(@pod.get('1')).to                 eq(@val1)
      @pod.set('5',@val3,5)
      @pod.set('0',@val4)
      expect(@pod.get_status.size()).to        eq(4)
      sleep(3.0)
      expect(@pod.get('2')).to be              nil
      expect(@pod.get_status.size()).to        eq(2)
    end
  end

  describe 'Delete' do
    before do
      @pod  = MemcachePod::Client.new(["localhost:11211"])
      @val1 = "val1"
      @val2 = "val2"
    end

    it "should" do
      @pod.set('1',@val1,1)
      @pod.set('2',@val2,2)
      expect(@pod.get('1')).to                 eq(@val1)
      @pod.delete('1')
      expect(@pod.get('1')).to be              nil
      expect(@pod.get('2')).to                 eq(@val2)
    end
  end
  
end
