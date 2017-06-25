# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sijka/version"

Gem::Specification.new do |spec|
  spec.name          = "sijka"
  spec.version       = Sijka::VERSION
  gem.authors       = ["Mario Sparta"]
  gem.email         = ["megosparta@mail.ru"]
  gem.summary       = "To smoke a cigarette."
  gem.description   = "Smoke without harm to health"
  gem.homepage      = "https://github.com/megosparta/Sijka"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  gem.add_dependency             'ruby-terminfo', '~> 0.1.1'
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
end
