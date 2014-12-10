# ジョブ実行
# 実際にはエラーハンドリングなどが必要と思います。

namespace :sqs do
  namespace :worker do
    desc 'Starts a new sqs worker'
    task :start, ['queue_name', 'max_number_of_messages'] => :environment do |task, args|
      sqs = Aws::SQS::Client.new
      queue_name = [
          ActiveJob::Base.queue_name_prefix,
          args.queue_name.presence || ActiveJob::Base.default_queue_name,
      ].compact.join('_')
      queue_url = sqs.get_queue_url(queue_name: queue_name)[:queue_url]

      begin
        num = (args.max_number_of_messages.presence || 10).to_i
        while true do
          resp = sqs.receive_message(queue_url: queue_url,
                                     max_number_of_messages: num)
          resp[:messages].each do |message|
            job_data = MultiJson.load(message[:body])
            SqsAdapter::JobWrapper.perform(job_data)
            sqs.delete_message(queue_url: queue_url,
                               receipt_handle: message[:receipt_handle])
          end
          sleep 1
        end
      rescue SignalException
        # C-c
      end
    end
  end
end