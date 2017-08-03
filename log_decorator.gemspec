# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'log_decorator/version'

Gem::Specification.new do |spec|
  spec.name          = "log_decorator"
  spec.version       = LogDecorator::VERSION
  spec.authors       = ["Richard Oliveri"]
  spec.email         = ["roliveri@redhat.com"]

  spec.summary       = "Add caller location information to log messages - class and method names."
  spec.description   = %q(
    Acts as a proxy to a configurable underlying logging mechanism,
    permitting the code to be executed in absence of the logger.

    Provides hooks to permit the "decoration" of log messages. By default,
    the class and method name of the caller are added to the log message.
  )
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "log4r"
end
