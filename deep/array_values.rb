module Deep
  module Matchers
    
    def have_array_values_in_class(expected)
      ArrayValues.new(expected)
    end

    # Checks that hash values are only String or Symbol
    # Usage : it { should have_values_in_class [String, Symbol] }
    class ArrayValues < HashMatchers

      def description 
        "have every value one of class: #{@expectation.join ','}"
      end

      def matches?(target)
        result = true
        @target, @actual = target, target.map(&:class).uniq

        case @target
        when Array
          result &&= (@actual - @expectation).empty?
        when Hash
          @target.each_value do |val|
            result &&= ArrayValues.new(@expectation).matches?(val) if val.is_a?(Hash) 
            result &&= ArrayValues.new(@expectation).matches?(val) if val.is_a?(Array) 
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
