# frozen_string_literal: true

require_relative 'helper'

describe 'Memory Size Management' do
  before do
    @pod = MemcachePod::Client.new(["localhost:11211"], {:max_memory => 10000 })
  end
  
  describe 'inserting to limit' do
    it "should" do
      1000.times {|i|
        key = sprintf( '%08d', i)
        @pod.set(key, '0123456789'*10, 3)
      }
      expect(@pod.get_memory_usage).to   eq(10000)

      sleep(5)
      expect(@pod.get('00000001')).to be   nil
      expect(@pod.get_memory_usage).to   eq(0)
    end
  end
end
