require 'rspec/core/rake_task'
require 'yard'

task :default => [:spec]

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'test/**/*_spec.rb'
end

YARD::Rake::YardocTask.new
