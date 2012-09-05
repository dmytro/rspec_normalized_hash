require 'spec_helper'

describe 'Normalized Hash - Array' do

  before(:each) { @hash = GOOD_HASH }

  context "simple" do
    context "Numeric array" do 
      subject { @hash[:n_array] }
      it { should have_array_values_in_class Numeric }
      it { should have_array_values_of_the_same_class }
      it "with different values should not have same class" do 
        subject << 'a'
        should_not have_array_values_of_the_same_class
      end
    end
    
    context "String array" do 
      subject { @hash[:s_array] }
      it { should have_array_values_in_class String }
    end

    context "mixed array" do 
      subject { @hash[:mix_array] }
      it { should     have_array_values_in_class [String,Numeric,Hash] }
      it { should_not have_array_values_in_class IO }
    end

    context "array of Hash'es" do
      subject { @hash[:array_hash] }
      it { should     have_array_values_in_class [String,Numeric,Hash] }
      it { should_not have_array_values_in_class IO }
    end
  end

  context "multi level" do 
    subject { @hash }
    it { should     have_array_values_in_class [String,Numeric,Hash] }
    it { should_not have_array_values_in_class IO }
    it { should_not have_array_values_of_the_same_class }
    it "when removed mixed array should all be in the same class" do 
      subject.delete :mix_array
      should have_array_values_of_the_same_class
    end
  end
end
