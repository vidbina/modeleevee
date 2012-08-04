# -*- encoding: utf-8 -*-
require File.expand_path('../lib/modeleevee/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Asabina"]
  gem.email         = ["david.asabina@gmail.com"]
  gem.description   = "A cute extension to bread-and-butter models." 
  gem.summary       = "Modeleeve supports binary ids in different scents and some smooth model methods that are bound on making things a bit easier, but note Modeleevee is just a little gem. Don't expect miracles just a soothing floral scent."
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "modeleevee"
  gem.require_paths = ["lib"]
  gem.version       = Modeleevee::VERSION

	gem.add_development_dependency "sqlite3",   '~> 1.3.6'
	gem.add_development_dependency "turn",      '~> 0.9.6'

	gem.add_runtime_dependency "activerecord",  '~> 3.2.6'
  gem.add_runtime_dependency 'activesupport', '~> 3.2.6'
end
