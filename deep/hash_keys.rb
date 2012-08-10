require 'pp'
module Deep
  module Matchers

    def have_keys_in_class(expected)
      DeepHashKeys.new(expected)
    end

    # Checks that hash keys are only String or Symbol
    # Usage : it { should have_keys_in_class [String, Symbol] }
    class DeepHashKeys

      def initialize(expectation)
        @expectation = expectation
      end

      def description 
        "have every key be one of class: #{[@expectation].flatten.join ','}"
      end

      def matches?(target)
# p target.keys.inspect          
        result = true
        
        if target.is_a? Hash
          @target = target

          case @expectation
          when Class
            result &&= [@expectation] == @target.keys.map(&:class).uniq
          when Array
            @target.keys.map(&:class).uniq.each do |kls|
              result &&= @expectation.include? kls
            end
          else
            raise ArgumentError, "#{@expectation.inspect}: Expectation data should be Class or Array[of Classes], got #{@expectation.class}"
          end
          
          @target.each_value do |val|
            if val.is_a? Hash
              result &&= val.is_a?(Hash) && DeepHashKeys.new(@expectation).matches?(val)
            end
          end

        end

        result
      end


      def failure_message_for_should
        "expected #{@target.keys.inspect} #{@target.keys.map(&:class).uniq} to be one of the #{@expectation.inspect}"
      end

      def failure_message_for_should_not
        "expected #{@target.keys.inspect} differ from  #{@expectation.inspect}"
      end
    end

  end
end
