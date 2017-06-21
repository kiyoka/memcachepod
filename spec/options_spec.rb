# frozen_string_literal: true

require_relative 'helper'

describe 'Options' do

  describe 'default values' do
    it "should" do
      pod = MemcachePod::Client.new(["localhost:11211"])
      expect(pod.get_options[:expires_in]).to     eq(0)
      expect(pod.get_options[:threadsafe]).to     eq(true)
      expect(pod.get_options[:namespace]).to      eq('')
      expect(pod.get_options[:max_memory]).to     eq(64*1024*1024)
    end
  end
  
  describe 'customized values' do
    it "should" do
      options = Hash.new
      options[:expires_in] = 60
      options[:threadsafe] = false
      options[:namespace]  = 'namespace1'
      options[:max_memory] = 12345678
      pod = MemcachePod::Client.new(["localhost:11211"],options)
      expect(pod.get_options[:expires_in]).to     eq(60)
      expect(pod.get_options[:threadsafe]).to     eq(false)
      expect(pod.get_options[:namespace]).to      eq('namespace1')
      expect(pod.get_options[:max_memory]).to     eq(12345678)
    end
  end

end
