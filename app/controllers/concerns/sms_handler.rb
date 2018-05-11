module SmsHandler
  include ActiveSupport::Concern

  def sms_handler(number_params, artist_params)
    users_phone = number_params
    artist = artist_params

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

  def boot_twilio
    RSpotify.authenticate(Rails.application.secrets.rspotify_client_id, Rails.application.secrets.rspotify_client_secret)
    @client = Twilio::REST::Client.new  Rails.application.secrets.twilio_account_sid,  Rails.application.secrets.twilio_auth_token
  end
end