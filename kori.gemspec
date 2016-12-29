# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'kori'
  spec.version       = '0.3.2'
  spec.authors       = ['nalabjp']
  spec.email         = ['nalabjp@gmail.com']

  spec.summary       = %q{Deep frozen objects from yaml or hash.}
  spec.description   = %q{Deep frozen objects from yaml or hash.}
  spec.homepage      = 'https://github.com/nalabjp/kori'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'ice_nine', '~> 0.11'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
