class HomeController < ApplicationController
  def index
  end

  def send_sms
    users_phone = params[:number]
    artist = params[:artist]
    boot_twilio

    artist = RSpotify::Artist.search(artist).first

    if artist.nil?
      return head :not_found
    else
      track = artist.top_tracks(:US).first
      body = "#{artist.name}'s top track: #{track.name}"
    end

    begin
      sms = @client.messages.create(
        from: Rails.application.secrets.twilio_phone_number,
        to: users_phone,
        body: body
      )
    rescue Twilio::REST::RestError => error
      return head 400
    end

    return head 200
  end

  private

  def boot_twilio
    RSpotify.authenticate(Rails.application.secrets.rspotify_client_id, Rails.application.secrets.rspotify_client_secret)
    @client = Twilio::REST::Client.new  Rails.application.secrets.twilio_account_sid,  Rails.application.secrets.twilio_auth_token
  end
end
