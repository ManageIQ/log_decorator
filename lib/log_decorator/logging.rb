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
      host_class.extend(ClassMethods)
    end

    def _log
      self.class.instance_logger
    end
  end
end
