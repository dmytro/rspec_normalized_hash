module Deep
  module Matchers

    def have_keys_in_class(expected)
      HashKeys.new(expected)
    end

    # Checks that hash keys are only String or Symbol
    # Usage : it { should have_keys_in_class [String, Symbol] }
    class HashKeys < HashMatchers

      def description 
        "have (recursively) every key one of class: #{[@expectation].flatten.join ','}"
      end

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
