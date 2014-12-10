class ExampleMailer < ApplicationMailer

  def hello(message)
    mail to: 'test@takeyu-web.com'
  end

end
