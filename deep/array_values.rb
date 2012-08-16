module Deep
  module Matchers
    
    def have_array_values_in_class(expected)
      ArrayValues.new(expected)
    end

    def have_array_values_of_the_same_class
      SameArrayValues.new Object # dummy class
    end

    class SameArrayValues < HashMatchers
      def description 
        "have all values of the same class"
      end

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
