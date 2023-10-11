LOGSTASH_LOGGER = LogStashLogger.new(
    type: :udp,
    host: 'logstash', 
    port: 5228, 
)