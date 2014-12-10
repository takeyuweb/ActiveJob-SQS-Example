require 'sqs_adapter'
ActiveJob::Base.queue_adapter = SqsAdapter
ActiveJob::Base.queue_name_prefix = Rails.env
