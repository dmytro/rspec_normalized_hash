module Deep
  module Matchers

    # Test that hash has only keys of expected class(es). 
    #
    # Check done hierarchically for all Hashes.
    #
    # @param [Array, Class] expected class(es) allowed
    #
    # == Usage
    #     it { @hash.should  have_keys_in_class [String,Numeric,Hash,Array] }
    #     it { @hash.should  have_keys_in_class Numeric }
    #
    def have_keys_in_class(expected)
      HashKeys.new(expected)
    end

    # RSpec::Matchers class for testing hierarchically hashes, that
    # are elements of deep hash. 
    # 
    # HashKeys class tests that all keys of the Hash belong to list of
    # Classes.
    # 
    # == Usage 
    #    it { @hash.should have_keys_in_class [String, Symbol] }
    #    it { @hash.should have_keys_in_class String }
    class HashKeys < HashMatchers

      def description 
        "have (recursively) every key one of class: #{[@expectation].flatten.join ','}"
      end

      # Test that all keys of the tested Hash belong to provided list
      # of classes
      #
      # @param [Hash] target hash under test
      #
      # @return true if pass, false if fail
      def matches?(target)
        result = true
        
        if target.is_a? Hash

          @target, @actual = target, target.keys.map(&:class).uniq

          result &&= (@actual - @expectation).empty?

          @target.each_value do |val|
            result &&= HashKeys.new(@expectation).matches?(val) if val.is_a? Hash
            @target = val unless result
          end
        end

        result
      end


      def failure_message_for_should
        "expected #{@target.keys.inspect} #{@actual} to be one of #{@expectation.inspect}"
      end

      def failure_message_for_should_not
        "expected #{@target.keys.inspect} differ from  #{@expectation.inspect}"
      end
    end

  end
end
