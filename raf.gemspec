# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "raf"
  spec.version       = `cat VERSION`
  spec.authors       = ["garin"]
  spec.email         = ["garin54@gmail.com"]
  spec.description   = %q{raf is simple document format}
  spec.summary       = %q{raf is simple document format}
  spec.homepage      = ""
  spec.license       = "GPLv3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency('raf-parser', '~>0.2.2')
  spec.add_dependency('raf2html', '~>0.0.7')
end
