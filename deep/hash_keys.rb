module Deep
  module Matchers

    def have_keys_in_class(expected)
      HashKeys.new(expected)
    end

    # Checks that hash keys are only String or Symbol
    # Usage : it { should have_keys_in_class [String, Symbol] }
    class HashKeys

      def initialize(expectation)
        @expectation = expectation
      end

      def description 
        "have (recursively) every key one of class: #{[@expectation].flatten.join ','}"
      end

      def matches?(target)
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
            raise ArgumentError, 
            "#{@expectation.inspect}: Expectation data should be Class or Array[of Classes], got #{@expectation.class}"
          end

          # FIXME: scoping (?) issue. When calling recursive failed
          # data are not reported correctly.

          @target.each_value do |val|
            if val.is_a? Hash
              result &&= val.is_a?(Hash) && HashKeys.new(@expectation).matches?(val)
            end
          end

        end

        result
      end


      def failure_message_for_should
        "expected #{@target.keys.inspect} #{@target.keys.map(&:class).uniq} to be one of #{@expectation.inspect}"
      end

      def failure_message_for_should_not
        "expected #{@target.keys.inspect} differ from  #{@expectation.inspect}"
      end
    end

  end
end
