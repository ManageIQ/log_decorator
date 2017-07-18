module LogDecorator
  class LogProxy
    attr_accessor :prefix, :logger

    def self.initialize_log_levels # rubocop:disable AbcSize
      return if @log_levels_initialized
      @log_levels_initialized = true

      LogDecorator.log_levels.each do |level|
        define_method(level) do |msg = nil, &blk|
          return unless logger # rubocop:disable Lint/NonLocalExitFromIterator
          location = caller_locations(1, 1)
          if blk
            logger.send(level) do
              "#{@prefix.call(@klass, @separator, location)} #{blk.call}"
            end
          else
            logger.send(level, "#{@prefix.call(@klass, @separator, location)} #{msg}")
          end
        end

        level_bool = :"#{level}?"
        define_method(level_bool) do
          return unless logger # rubocop:disable Lint/NonLocalExitFromIterator
          logger.send(level_bool)
        end
      end
    end

    def initialize(klass, separator)
      self.class.initialize_log_levels
      @klass     = klass
      @separator = separator
      @prefix    = LogDecorator.prefix
      @logger    = LogDecorator.logger
    end

    def level
      logger.level if logger
    end

    def level=(level)
      logger.level = level if logger
    end

    def log_backtrace
      logger.log_backtrace if logger
    end
  end
end
