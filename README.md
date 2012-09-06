
Normalized Hash tests for RSpec
===============================

These are RSpec tests for Normalized Hash data structure standard. Standard itself and rationale why we (I) need it, is described in NormalizedHash.md file.


RSpec deep hash tests were insired by https://github.com/vitalish/rspec-deep-matchers specs.

Usage
-----


````ruby

   require 'rspec_normalized_hash'

   describe "Good data structure" do

       before(:each) { subject @data }

       it { should have_keys_in_class [String, Symbol] }
       it { should have_values_in_class [Fixnum, String, Numeric, Hash, Array] }
       it { should have_array_values_in_class [String,Numeric,Hash] }
       it { should have_array_values_of_the_same_class }

       it { NOT IMPLEMENTED: enclosed arrays in Hash }
   end
                                   
````

License 
=======

Apache 2

Author
======

Dmytro Kovalov

dmytro.kovalov@gmail.com

Aug,Sept 2012
