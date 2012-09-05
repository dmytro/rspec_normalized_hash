require 'spec_helper'

describe 'Normalized Hash - enclosing array' do

  before(:each) { @hash = GOOD_HASH }
  
  context "Hash enclosed in Array " do 
    context "Hash-> Array-> [Hash]" do 
      context :simple do 
        subject {  @hash[:names] }
        it { should have_all_keys_be_word_name_or_singular_of :names }
        it { @hash[:people].should have_all_keys_be_word_name_or_singular_of :people}

        it { should_not have_all_keys_be_word_name_or_singular_of :last_names }
        it { @hash[:people].should have_all_keys_be_word_name_or_singular_of :people}
      end

      context :simple_changed do 
        subject {  @hash[:names] << { :not_really_name => 'some string', :name => 'name' } }
        it { should have_all_keys_be_word_name_or_singular_of :names }
        it { should_not have_all_keys_be_word_name_or_singular_of :last_names }
      end
    end # context "keys of Hash enclosed in an Array" do 

    context "Hash-> [Array]-> Hash " do
      context "one level" do
        subject { {:people => @hash[:people]} }
        it { should all_arrays_have_hash_with_key_word_name_or_singular_of_hash_key }
      end

      context '2 levels' do 
        subject { 
           { 
          #:single_levels => [
#                         { :single_level => 1},
#                         { :single_level => 2},
#                        ],
            :deep => 
            { :two_levels => 
              [
               { :name => :one},
               { :name => :two},
              ]
            }
          }
        }
        it { should all_arrays_have_hash_with_key_word_name_or_singular_of_hash_key }
      end
    end # context "Hash-> [Array]-> Hash" do 
  end #  context "enclosed in Array Hash" do 
end
