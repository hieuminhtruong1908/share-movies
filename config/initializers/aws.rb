require 'aws-sdk-s3'

Aws.config.update(
  region: ENV.fetch("AWS_S3_REGION", 'app-northeast-1'),
  credentials: Aws::Credentials.new(
    Rails.application.credentials.dig(:aws, :access_key_id),
    Rails.application.credentials.dig(:aws, :secret_access_key)
  )
)
S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['AWS_S3_BUCKET'])