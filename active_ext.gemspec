# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'darthjee/active_ext/version'

Gem::Specification.new do |gem|
  gem.name          = 'darthjee-active_ext'
  gem.version       = Darthjee::ActiveExt::VERSION
  gem.authors       = ['Darthjee']
  gem.email         = ['darthjee@gmail.com']
  gem.summary       = 'Active Extensions'
  gem.homepage      = 'https://github.com/darthjee/active_ext'
  gem.description   = 'Extension of active support classes with usefull methods'

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'activesupport',     '>= 5.x'
  gem.add_runtime_dependency 'darthjee-core_ext', '>= 1.5.6'

  gem.add_development_dependency 'activerecord', '~> 5.x'
  gem.add_development_dependency 'sqlite3'

  gem.add_development_dependency 'bundler',     '>= 1.6'
  gem.add_development_dependency 'rake',        '>= 11.3.0'
  gem.add_development_dependency 'rspec',       '>= 2.14'
  gem.add_development_dependency 'rspec-mocks', '>= 2.99.4'
  gem.add_development_dependency 'simplecov',   '>= 0.14.1'
end
