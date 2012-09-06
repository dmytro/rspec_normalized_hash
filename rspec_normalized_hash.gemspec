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
  s.summary     = %q{Recursive Hash structure matcher for rspec.}
  s.description = " Specification of Normalized Hash data structure main goal is to make data produced by parsers easy to use by software that does not know about internal data structure, i.e. data driven and schema-less. Data structures should be built in such a way as to make data self-documenting, easy adaptable and 'software-friendly'.
Gem contains RSpec tests for testing Hash data structure for compliance with the requirements.
See README.md and NormalizedHash.md files in gem's root directory."

  s.rubyforge_project = "normalized-hash"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rspec', '>= 2.0.0'
  s.add_dependency 'active_support'
  s.add_dependency 'i18n'


  s.add_development_dependency('rb-fsevent')
  s.add_development_dependency('guard-rspec')
  s.add_development_dependency('growl')
end
