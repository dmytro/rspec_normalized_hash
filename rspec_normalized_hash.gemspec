# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "rspec_normalized_hash"
  s.version     = NormalizedHash::Matchers::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["dmytro"]
  s.email       = ["dmytro.kovalov@gmail.com"]
  s.homepage    = "http://github.com/dmytro/rspec_normalized_hash"
  s.summary     = %q{Recursive Hash structure matcher for rspec}
  s.description = s.summary

  #s.rubyforge_project = ""

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rspec', '>= 2.0.0'

  s.add_development_dependency('guard-rspec')
  s.add_development_dependency('growl')
end
