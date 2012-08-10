$: << File.dirname(__FILE__)
require "deep/hash_keys"
module RSpec::Matchers
  include Deep::Matchers
end
