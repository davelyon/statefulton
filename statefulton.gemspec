# -*- encoding: utf-8 -*-
require File.expand_path('../lib/statefulton/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Dave Lyon", "Matt Polito"]
  gem.email         = ["gems@davelyon.net"]
  gem.description   = %q{A simple utility to manage state when testing}
  gem.summary       = %q{A fancy way to manage state in complex environments. Helpful when in Cucumber with lots of expected state.}
  gem.homepage      = "https://github.com/davelyon/statefulton"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "statefulton"
  gem.require_paths = ["lib"]
  gem.version       = Statefulton::VERSION

  gem.add_development_dependency "rspec", "~> 2.7"
end
