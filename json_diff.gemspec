$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'json_diff/version'

Gem::Specification.new do |s|
  s.authors = ['Chris Roberts']
  s.files = ['LICENSE.md', 'lib/json_diff.rb', 'lib/json_diff/version.rb']
  s.name = 'json_diff'
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.summary = 'A gem to compare JSON object trees'
  s.description = 'A gem to compare JSON object trees'
  s.version = JSONDiff::Version::STRING
  s.email = ['chrisvroberts@gmail.com']
  s.homepage = 'https://github.com/chrisvroberts/json_diff'
  s.license = 'MIT'
  s.add_development_dependency 'rake', '~> 10.5'
  s.add_development_dependency 'rspec', '~> 3.4'
  s.add_development_dependency 'json', '~> 1.8', '>= 1.8.3'
end
