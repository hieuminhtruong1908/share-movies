Rails.application.configure do
    config.lograge.enabled = true
    config.lograge.keep_original_rails_log = true
    config.lograge.formatter = Lograge::Formatters::Logstash.new
    config.lograge.custom_options = lambda do |event|
        { 
            time: Time.zone.now,
            payload: RequestStore.store[:payload]
         }
    end
    config.lograge.logger = LogStashLogger.new(
        type: :udp,
        host: 'logstash', 
        port: 5228, 
    )
end