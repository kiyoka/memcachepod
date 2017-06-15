require './lib/memcachepod/version'

Gem::Specification.new do |s|
  s.name = "memcachepod"
  s.version = MemcachePod::VERSION
  s.license = "MIT"

  s.authors = ['Kiyoka Nishiyama']
  s.description = s.summary = ''
  s.email = ['kiyoka@sumibi.org']
  s.files = Dir.glob('lib/**/*') + [
    'LICENSE',
    'README.md',
    'Gemfile'
  ]
  s.homepage = 'https://github.com/kiyoka/memcachepod'
  s.rdoc_options = ["--charset=UTF-8"]
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rdoc'
end
