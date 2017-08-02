module LogDecorator
  module Logging
    module ClassMethods
      def instance_logger
        @instance_logger ||= LogProxy.new(name, '#')
      end

      def _log
        @_log ||= LogProxy.new(name, '.')
      end

      def _logger=(logger)
        _log.logger = logger
        instance_logger.logger = logger
      end

      def _log_prefix=(prefix)
        _log.prefix = prefix
        instance_logger.prefix = prefix
      end
    end

    def self.included(host_class)
      host_class.extend(ClassMethods) unless host_class.respond_to?(:_log)
      host_class.instance_logger
      host_class._log
    end

    def _log
      self.class.instance_logger
    end
  end
end
