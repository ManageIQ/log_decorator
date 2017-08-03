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

require "log4r"

module TestLog
  class ConsoleFormatter < Log4r::Formatter
    def format(event)
      (event.data.is_a?(String) ? event.data : event.data.inspect) + "\n"
    end
  end

  def self.log_init(log_level = 'DEBUG')
    log = Log4r::Logger.new 'toplog'
    log.level = case log_level
                when 'ERROR' then Log4r::ERROR
                when 'WARN'  then Log4r::WARN
                when 'INFO'  then Log4r::INFO
                when 'DEBUG' then Log4r::DEBUG
                else              Log4r::OFF
                end
    Log4r::IOOutputter.new('err_console', sio, :formatter => ConsoleFormatter)
    log.add 'err_console'
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
