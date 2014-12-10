class HelloController < ApplicationController
  def index
  end

  def world
    if params[:immediately].present?
      HelloJob.perform_later(params[:message])
    else
      HelloJob.set(wait: 1.minute).perform_later(params[:message])
    end
    flash.notice = 'Enqueue OK'
    redirect_to root_url
  end

end
