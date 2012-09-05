
#
# TEST DATA: Good normalized hash for use in tests
# ================================================
GOOD_HASH =  { 
  :symbol => { :str => 'str',  :num => 42,  :arr => [1,2,3]  }, # single symbol key
  :string => { 'str' => 'str', 'num' => 42, 'arr' => [1,2,3] }, # single string key
  :sym_str => { 
    :a => 1, :aa => 'a',
    'b' => 2, 'bb' => 'bb'
  },
  :l2 => {  # level 2 hash
    :aa => 1,  
    :bb => { :bbb => [1,2,3], 'ccc' => "string", :ddd => 42 }, # symbol and string keys
    'cc' => 3 
  },
  :b => { 
    :ba => 1, 
    :bb => 2, 
    'bc' => { :caa => 1, :cbb => 'asdfas', 'dd' => 'file'}, 
    'abc' => 'a' 
  },
  :n_array => [1,2,3,4],
  :s_array => ["a","b","c"],
  :mix_array => [1, "a", {} ],
  :array_hash => 
  [
   { :name =>'a' },
   { :name =>'b' },
   { :name =>'c' },
  ],
  
  :names => 
  [
   { :name =>'a' },
   { :name =>'b' },
   { :name =>'c' },
  ],
  
  :people => 
  [
   { :person =>'a' },
   { :person =>'b' },
   { :person =>'c' },
  ]
}

# ============================================================
@enclosed_hash = { 
  :simple => [
              { },
              { },
              { },
             ],
  :nested => { 
    :level2 => [
                { },
                { },
                { },
               ]
  }
}
# ============================================================
