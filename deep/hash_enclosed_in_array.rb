
require 'active_support/all'

module Deep
  module Matchers

    # Test that array has only elements of expeted class(es). 
    #
    # @param TODO
    #
    # = Usage
    #     it { @TODO.should TODO }
    #
    def have_all_keys_be_word_name_or_singular_of (expected)
      KeyNamesOfEnclosedHash.new(expected)
    end

    def all_arrays_have_hash_with_key_word_name_or_singular_of_hash_key
      HashEnclosingArray.new
    end

    # Simple class to be inherited by other matcher classes that take
    # String expectation.
    class KeyNameMatchers
      def initialize(expectation)
        expectation = expectation.to_s.downcase
        @expectation = expectation.singularize
        raise ArgumentError, "#{expectation} must have singular form. Got #{@expectation}" if @expectation == expectation
      end
    end

    # RSpec::Matchers class for testing hashes enclosed in an array.
    # 
    # Array of Hashes: each Hash should have key :name or :<collection.singularize>
    #
    # Hash here (subject) is an instance of Hash, which is an element
    # of an Array, and Array itself is a value of a Hash:
    #
    #     { :foos => 
    #           [                               <--- subject
    #                 { :foo (or :name) => ...,
    #                   :bar => ...,
    #                 },
    #                 { :foo (or :name) => ...,
    #                   :bar => ...,
    #                 },
    #                ]
    #     }
    class KeyNamesOfEnclosedHash < KeyNameMatchers
      def description 
        "have key :name or '#{@expectation.singularize}' in every enclosed Hash "
      end

      # Test that all values of the tested Array are of the same class
      #
      # @param [Array] target tested array
      #
      # @return true if pass, false if fail
      def matches? target
        @target = target 
        result = true

        target.each do |hash|
          next unless hash.is_a? Hash
          keys = hash.keys.map(&:to_s).map(&:downcase)
          result &&= false unless (keys.include? @expectation || keys.include?("name"))
        end

        result
      end

      def failure_message_for_should
        "expected each of #{@target.map(&:keys)} include '#{@expectation.singularize}'"
      end
      
      def failure_message_for_should_not
        "expected #{@target.map(&:keys)} not include '#{@expectation.singularize}'"
      end
    end # class KeyNamesOfEnclosedHash < HashMatchers

    # Hash (subject) ancloses Array wit ha bunch of Hases inside. Each
    # aHas is then tested by KeyNamesOfEnclosedHash
    #
    #
    #     { :foos =>                          <--- subject 
    #              [
    #                 { :foo (or :name) => ...,   
    #                   :bar => ...,
    #                 },
    #                 { :foo (or :name) => ...,
    #                   :bar => ...,
    #                 },
    #                ]
    #     }
    class HashEnclosingArray
      def description
        "enclose Arrays of Hashes with key #{@target.keys}"
      end

      def failure_message_for_should;  description + @failure; end
      def failure_message_for_should_not; 'not ' + description end


      def matches? target

        @target = target
        result = true
        @failure = ":\n"
        
        if @target.is_a? Hash
          target.each do |key,array|
            if array.is_a? Array
              res = KeyNamesOfEnclosedHash.new(key).matches?(array)
              result &&= res
              @failure << { key => array}.inspect unless res
            end
          end
        end
        
        
        result
      end
      
    end # ArrayEnclosingHashes < KeyNameMatchers

  end  
end

