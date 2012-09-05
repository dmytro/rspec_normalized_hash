require 'spec_helper'

describe 'Normalized Hash - keys and values' do

  before(:each) { @hash = GOOD_HASH }
  # ------------------------------------------------------------
  context 'Hash keys and values' do
    context "simple hash" do
      
      context "single Symbol key" do
        subject { @hash[:symbol] }

        it { should      have_keys_in_class Symbol }
        it { should_not  have_keys_in_class String }

        it { should      have_values_in_class [String, Numeric, Array, Hash] }
        it { should_not  have_values_in_class IO }

        it { should  have_array_values_in_class [Numeric, String, Hash] }

      end
      
      context "single String key" do
        subject { @hash[:string] }

        it { should      have_keys_in_class String }
        it { should_not  have_keys_in_class Symbol }

        it { should      have_values_in_class [String, Numeric, Array, Hash] }
        it { should_not  have_values_in_class IO }
      end
      
      context "Symbol and String keys" do
        subject { @hash[:sym_str] }
        
        it { should     have_keys_in_class [Symbol, String] }
        it { should     have_keys_in_class [Symbol, String, File] }
        it { should_not have_keys_in_class [Symbol, File] }
        it { should_not have_keys_in_class Symbol }
        it { should_not have_keys_in_class String }
      end

      context "nested Hash" do
        
        context "2 levels" do
          subject { @hash[:l2] }
          it { should                                  have_keys_in_class [Symbol, String] }
          it { subject.merge({[1,2] => 1 }).should_not have_keys_in_class [Symbol, String] }

          it { should      have_values_in_class [String, Numeric, Array, Hash] }
          it { should_not  have_values_in_class IO }

        end
        
        context "3 levels" do
          subject {  @hash }
          it { should have_keys_in_class [Symbol, String] }


          it {
            bad = { :a => { :b => { :bbb => [1,2,3], 'ccc' => "string", 42 => 42 }}}
            bad.should_not  have_keys_in_class [Symbol, String]
          }

          it { should      have_values_in_class [String, Numeric, Array, Hash] }
          
          it {
            subject.merge(
                          { :file => File.new('.tmp','w') }
                          ).should_not have_values_in_class [String, Numeric, Array, Hash]
          }
        end # 3 levels
      end # nested Hash
    end # Hash  


  end # context 'Hash keys and values' do
end
