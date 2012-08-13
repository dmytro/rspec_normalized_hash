module Deep
  module Matchers

    def have_values_in_class(expected)
      HashValues.new(expected)
    end

    # Checks that hash values are only String or Symbol
    # Usage : it { should have_values_in_class [String, Symbol] }
    class HashValues

      def initialize(expectation)
        @expectation = expectation
      end

      def description 
        "have (recursively) every value one of class: #{[@expectation].flatten.join ','}"
      end

      def matches?(target)
        result = true
        
        if target.is_a? Hash
          @target = target

          case @expectation
          when Class
#            result &&= [@expectation] == @target.values.map(&:class).uniq
          when Array
#             @target.values.map(&:class).uniq.each do |kls|
#               result &&= @expectation.include? kls
#             end
          else
            raise ArgumentError, 
            "#{@expectation.inspect}: Expectation data should be Class or Array[of Classes], got #{@expectation.class}"
          end

          # FIXME: scoping (?) issue. When calling recursive failed
          # data are not reported correctly.

          @target.each_value do |val|
            if [@expectation].flatten.include? val.class
p [@expectation].flatten
p val.class
              result &&= val.is_a?(Hash) && HashValues.new(@expectation).matches?(val)
            else
              result = false
              # WRONG!!
              #             when Array
              #               result &&= ArrayValues.new(@expectation).matches?(val)
            end
          end

        end

        result
      end


      def failure_message_for_should
        "expected #{@target.values.inspect} #{@target.values.map(&:class).uniq} to be one of the #{@expectation.inspect}"
      end

      def failure_message_for_should_not
        "expected #{@target.values.inspect} differ from  #{@expectation.inspect}"
      end
    end

  end
end
