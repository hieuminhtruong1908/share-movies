class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.debug "Hello World"
    raise 'Error executing'
  rescue => e
    LOGSTASH_LOGGER.debug error: e.message, messages: 'abcdf'
  end
end
