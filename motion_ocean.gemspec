# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'motion_ocean/version'

Gem::Specification.new do |spec|
  spec.name          = "motion_ocean"
  spec.version       = MotionOcean::VERSION
  spec.authors       = ["Erwin Boskma"]
  spec.email         = ["erwin@datarift.nl"]
  spec.summary       = %q{Digital Ocean API implementation for RubyMotion}
  spec.description   = %q{MotionOcean, for RubyMotion, is an implementation of v2 of the Digital Ocean API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir.glob('lib/**/*.rb')
  spec.files        << "README.md"
  spec.test_files    = Dir.glob('spec/**/*.rb')
  spec.require_paths = ["lib"]
  
  spec.add_dependency 'dbt'
  spec.add_dependency 'afmotion'
  
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'webstub'
  spec.add_development_dependency 'motion-redgreen'
  spec.add_development_dependency 'bacon-expect'
end
