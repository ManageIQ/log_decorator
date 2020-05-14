# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'log_decorator/version'

Gem::Specification.new do |spec|
  spec.name          = "log_decorator"
  spec.version       = LogDecorator::VERSION
  spec.authors       = ["ManageIQ Authors"]

  spec.summary       = "Add caller location information to log messages - class and method names."
  spec.description   = %q(
    Acts as a proxy to a configurable underlying logging mechanism,
    permitting the code to be executed in absence of the logger.

    Provides hooks to permit the "decoration" of log messages. By default,
    the class and method name of the caller are added to the log message.
  )
  spec.homepage      = "https://github.com/ManageIQ/log_decorator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 1.0.0"
  spec.add_development_dependency "simplecov"
end
