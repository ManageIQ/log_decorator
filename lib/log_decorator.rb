require "log_decorator/version"
require "log_decorator/log_proxy"
require "log_decorator/logging"

module LogDecorator
  DEFAULT_PREFIX = lambda do |klass, separator, location|
    location = location.first if location.is_a?(Array)
    meth = location.base_label
    meth ? "#{klass}#{separator}#{meth}" : klass
  end

  DEFAULT_LOG_LEVELS = [:debug, :info, :warn, :error]

  class << self
    attr_writer :prefix, :log_levels
    attr_accessor :logger

    def prefix
      @prefix ||= DEFAULT_PREFIX
    end

    def log_levels
      @log_levels ||= DEFAULT_LOG_LEVELS
    end
  end
end
