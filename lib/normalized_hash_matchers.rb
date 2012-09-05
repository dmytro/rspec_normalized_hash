$: << File.dirname(__FILE__)
require "normalized_hash/matchers"
require "normalized_hash/hash_keys"
require "normalized_hash/hash_values"
require "normalized_hash/array_values"
require "normalized_hash/hash_enclosed_in_array"
module RSpec::Matchers
  include NormalizedHash::Matchers
end
