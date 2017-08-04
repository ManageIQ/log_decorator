if ENV['CI']
  require 'simplecov'
  SimpleCov.start
end

require "bundler/setup"
require "log_decorator"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
end

module TestLog
  def self.log_init
    require 'logger'
    log = Logger.new(sio)
    log.level = Logger::DEBUG
    log.formatter = lambda { |_severity, _datetime, _progname, msg| "#{msg}\n" }
    LogDecorator.logger = log
  end

  def self.sio
    @sio ||= StringIO.new
  end
end

TestLog.log_init

class TestClass1
  include LogDecorator::Logging

  def self.cmethod
    _log.debug "called"
  end

  def imethod
    _log.debug "called"
  end
end
