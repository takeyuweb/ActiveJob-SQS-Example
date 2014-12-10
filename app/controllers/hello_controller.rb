class HelloController < ApplicationController
  def index
  end

  def world
    HelloJob.set(wait: 1.minute).perform_later(params[:message])
    flash.notice = 'Enqueue OK'
    redirect_to root_url
  end

end
