# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = 'rack-no_animations'
  spec.version       = '1.0.3'
  spec.authors       = ['Michal Cichra']
  spec.email         = ['michal@o2h.cz']

  spec.summary       = %q{Injects CSS and JavaScript snippet to stop CSS and jQuery animations.}
  spec.description   = %q{Rack middleware to stop CSS/jQuery animations.}
  spec.homepage      = 'https://github.com/mikz/rack-no_animations'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*.rb'] + %w[LICENSE.txt]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
