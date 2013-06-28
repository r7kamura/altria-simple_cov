lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "altria/simple_cov/version"

Gem::Specification.new do |spec|
  spec.name          = "altria-simple_cov"
  spec.version       = Altria::SimpleCov::VERSION
  spec.authors       = ["Ryo Nakamura"]
  spec.email         = ["r7kamura@gmail.com"]
  spec.summary       = "Altria simplecov integration plugin"
  spec.homepage      = "https://github.com/r7kamura/altria-simple_cov"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "altria", ">= 0.1.5"
  spec.add_dependency "altria-git"
  spec.add_dependency "chartkick"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
