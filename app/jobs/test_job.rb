class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.debug "Hello World"
    raise 'Error executing'
  end
end
