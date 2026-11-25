# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
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
  gem.required_ruby_version = '>= 3.3.1'

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency 'activesupport',     '~> 7.2.x'
  gem.add_dependency 'darthjee-core_ext', '>= 3.2.0'
  gem.metadata['rubygems_mfa_required'] = 'false'
end
