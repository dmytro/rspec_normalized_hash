$: << File.dirname(__FILE__)
require "deep/hash_matchers"
require "deep/hash_keys"
require "deep/hash_values"
require "deep/array_values"
module RSpec::Matchers
  include Deep::Matchers
end
