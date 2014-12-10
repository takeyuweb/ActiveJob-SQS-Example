require 'aws-sdk-core'

class SqsAdapter
  class << self
    def enqueue(job)
      raise job.serialize
    end

    def enqueue_at(job, timestamp)
      delay = timestamp.to_i - Time.current.to_i
      resp = sqs.create_queue(
          queue_name: job.queue_name,
      )
      sqs.send_message(
          queue_url: resp[:queue_url],
          message_body: MultiJson.dump(job.serialize),
          delay_seconds: delay,
      )
    end

    def sqs
      Aws::SQS::Client.new
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