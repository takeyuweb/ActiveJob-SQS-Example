require 'aws-sdk-core'

Aws.config[:region] = ENV['AWS_REGION']
Aws.config[:access_key_id] = ENV['AWS_ACCESS_KEY_ID']
Aws.config[:secret_access_key] = ENV['AWS_SECRET_ACCESS_KEY']
