class HelloJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    ExampleMailer.hello(message).deliver_now
  end
end
