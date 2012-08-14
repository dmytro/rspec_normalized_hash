module Deep
  module Matchers
    
    def have_values_in_class(expected)
      HashValues.new(expected)
    end

    # Checks that hash values are only String or Symbol
    # Usage : it { should have_values_in_class [String, Symbol] }
    class HashValues < HashMatchers

      def description 
        "have (recursively) every value one of class: #{[@expectation].flatten.join ','}"
      end

      def matches?(target)
        result = true

        if target.is_a? Hash
          @target, @actual = target, target.values.map(&:class).uniq

          result &&= (@actual - @expectation).empty?
          
          @target.each_value do |val|
            result &&= HashValues.new(@expectation).matches?(val) if val.is_a?(Hash)
            @target = val unless result
          end
        end

        result
      end


      def failure_message_for_should
        "expected #{@target.values.inspect} to have values of classes #{@expectation.inspect}"
      end

      def failure_message_for_should_not
        "expected #{@target.values.inspect} differ from  #{@expectation.inspect}"
      end
    end

  end
end
