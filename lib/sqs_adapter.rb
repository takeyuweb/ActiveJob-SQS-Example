require 'aws-sdk-core'

class SqsAdapter
  class << self
    def enqueue(job)
      sqs.send_message(
          queue_url: get_queue_url(job),
          message_body: MultiJson.dump(job.serialize)
      )
    end

    def enqueue_at(job, timestamp)
      delay = timestamp.to_i - Time.current.to_i
      sqs.send_message(
          queue_url: get_queue_url(job),
          message_body: MultiJson.dump(job.serialize),
          delay_seconds: delay,
      )
    end

    def sqs
      Aws::SQS::Client.new
    end

    def get_queue_url(job)
      sqs.create_queue(queue_name: job.queue_name)[:queue_url]
    end
  end

  class JobWrapper
    class << self
      def perform(job_data)
        ActiveJob::Base.execute job_data
      end
    end
  end
end