
Normalized Hash tests
=====================

These are RSpec tests for Normalized Hash data structure standard. Standard itself and rationale why we (I) need it, is described in NormalizedHash.md file.


RSpec deep hash tests were insired by https://github.com/vitalish/rspec-deep-matchers specs.

Usage
-----


````ruby

   describe "Good data structure" do

       before(:each) { @data = File.read("#{DATA_ROOT}/#{$data_file}") }

       it { should have_keys_in_class [String, Symbol] }
       it { should have_values_in_class [Fixnum, String, Numeric, Hash, Array] }
       it { should have_array_values_in_class [String,Numeric,Hash] }
       it { should have_array_values_of_the_same_class }

       it { TODO: enclosed arrays in Hash }
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
