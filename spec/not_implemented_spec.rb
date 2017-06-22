# frozen_string_literal: true

require_relative 'helper'

describe 'Not Implemented' do
  before do
    @pod = MemcachePod::Client.new(["localhost:11211"])
  end
  
  describe 'exceptions' do
    it "should" do
      expect{@pod.add('1',1)}.to         raise_error(NotImplementedError)
      expect{@pod.replace('1',1)}.to     raise_error(NotImplementedError)
      expect{@pod.append('1',1)}.to      raise_error(NotImplementedError)
      expect{@pod.prepend('1',1)}.to     raise_error(NotImplementedError)
      expect{@pod.incr('1',1)}.to        raise_error(NotImplementedError)
      expect{@pod.decr('1',1)}.to        raise_error(NotImplementedError)
      expect{@pod.touch('1')}.to         raise_error(NotImplementedError)
      expect{@pod.stats()}.to            raise_error(NotImplementedError)
      expect{@pod.reset_stats()}.to      raise_error(NotImplementedError)
      expect{@pod.alive!()}.to           raise_error(NotImplementedError)
    end
  end
end
