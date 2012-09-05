module NormalizedHash
  module Matchers
    
    # All numeric classes we want to consider
    NUMBERS = [Fixnum, Bignum, Numeric, Float]

    class HashMatchers

      def initialize(expectation)
        # Convert to array for simpler checks
        @expectation = [expectation].flatten
        
        # All expectionations should be Class, no other classes
        unless @expectation.map(&:class).uniq == [Class]
          raise ArgumentError,
          "#{@expectation.inspect}: Expectation should be Class or Array[of Classes], got #{@expectation.class}"
        end

        # Expand expectation with all numeric classes if at least one
        # numeric present.
        (@expectation += NUMBERS).uniq! unless (@expectation & NUMBERS).empty?

      end
    end
  end
end
