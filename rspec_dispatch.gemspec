# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec_dispatch/version'

Gem::Specification.new do |s|
  s.name          = "rspec_dispatch"
  s.version       = RspecDispatch::VERSION
  s.authors       = ["Kevin Wanek"]
  s.email         = ["kevin@gekkobyte.com"]
  s.summary       = "A custom RSpec formatter to post RSpec suite results to a web service."
  s.description   = "See summary..."
  s.homepage      = "https://github.com/theef/rspec_dispatch"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency 'bundler', '~> 1.6'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'pry'

  s.add_dependency 'rspec'
  s.add_dependency 'httparty'
end
