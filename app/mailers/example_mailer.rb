class ExampleMailer < ApplicationMailer

  def hello(message)
    @message = message
    mail to: 'test@takeyu-web.com'
  end

end
