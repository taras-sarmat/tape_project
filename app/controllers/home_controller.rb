class HomeController < ApplicationController
  include SmsHandler

  def index; end

  def send_sms
    sms_handler(params[:number], params[:artist])
  end
end
