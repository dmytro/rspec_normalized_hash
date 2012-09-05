module NormalizedHash
  module Matchers

    # Test that array has only elements of expeted class(es). 
    #
    # Array is a value in deep (multilevel) hash.  Check done
    # hierarchically for all arrays' values.
    #
    # @param [Array, Class] expected class(es) allowed
    #
    # = Usage
    #     it { @hash.should  have_array_values_in_class [String,Numeric,Hash] }
    #     it { @hash.should  have_array_values_in_class Numeric }
    #
    def have_array_values_in_class(expected)
      ArrayValues.new(expected)
    end

    # Test that array elements are all in the same class.
    #
    # Array is a value in deep (multilevel) hash. Check done
    # hierarchically for all arrays' values.
    #
    # @param none
    #
    # = Usage
    #     it { @hash.should  have_array_values_of_the_same_class }
    #
    def have_array_values_of_the_same_class
      SameArrayValues.new Object # dummy class, not used but needs to
                                 # be here because of constructor
    end

    # RSpec::Matchers class for testing hierarchically arrays, that
    # are elements of deep hash. 
    # 
    # SameArrayValues class tests that all values of the Array are on
    # the same class.
    class SameArrayValues < HashMatchers
      def description 
        "have all values of the same class"
      end

      # Test that all values of the tested Array are of the same class
      #
      # @param [Array] target tested array
      #
      # @return true if pass, false if fail
      def matches? target
        result = true
        case target
        when Array
          @actual = target.map(&:class).uniq
          result = !(@actual.count > 1)
        when Hash

          target.each_value do |val|
            if val.is_a? Array
              result &&= SameArrayValues.new(Object).matches? val
              @actual = val.map(&:class).uniq unless result
            end
          end

        end
        result
      end

      def failure_message_for_should
        "expected #{@actual.inspect} to be one class"
      end

      def failure_message_for_should_not
        "expected #{@actual.inspect} be at least 2 different classes"
      end

    end


    # RSpec::Matchers class for testing hierarchically arrays, that
    # are elements of deep hash. 
    # 
    # ArrayValues class ensures that all values of the tested
    # Array belong to expected classes.
    class ArrayValues < HashMatchers

      def description 
        "have every value one of class: #{@expectation.join ','}"
      end

      # Test that all values of the tested Array belong to expecetd
      # class(es).
      #
      # @param [Array] target array to test
      #
      # @return true if pass, false if fail
      def matches?(target)
        result = true
        @target, @actual = target, target.map(&:class).uniq

        case @target
        when Array
          result &&= (@actual - @expectation).empty?
        when Hash
          @target.each_value do |val|
            result &&= ArrayValues.new(@expectation).matches?(val) if [Hash, Array].include? val.class
            @target = val unless result
          end
        end

        result
      end


      def failure_message_for_should
        "expected #{@target.inspect} to have values of classes #{@expectation.inspect}"
      end

      def failure_message_for_should_not
        "expected #{@target.inspect} differ from  #{@expectation.inspect}"
      end
    end

  end
end
