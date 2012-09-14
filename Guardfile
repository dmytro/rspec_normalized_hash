# A sample Guardfile
# More info at https://github.com/guard/guard#readme
# Guardfile

### http://stackoverflow.com/questions/11198446/guard-executes-shell-scripts-twice
### class GFilter
###   def self.run(files, &block)
###     @mtimes ||= Hash.new
### 
###     files.each { |f|
###       mtime = File.mtime(f)
###       next if @mtimes[f] == mtime
###       @mtimes[f] = mtime
### 
###       yield f
###     }
###   end
### end
### 
### guard 'shell' do
###   watch(/^test\.txt$/) {|m| GFilter.run(m) { |f| puts "File: #{f}" } }
### end

guard 'rspec', :version => 2, :cli => "--color --format nested" do
  watch(%r{^spec/[^\.]+_spec\.rb})
  watch(%r{^lib/\w(.+:w)\.rb})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { "spec" }
end
