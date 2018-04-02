class HomeController < ApplicationController
  def index
  end

  def send_sms
    users_phone = params[:number]
    artist = params[:artist]
    boot_twilio

    artist = RSpotify::Artist.search(artist).first
    track = artist.top_tracks(:US).first
    body = "#{artist.name}'s top track: #{track.name}"
    begin
      sms = @client.messages.create(
        from: '+18317132777',
        to: users_phone,
        body: body
      )
    rescue Twilio::REST::TwilioError => e
      print e.message
    end
  end

  private

  def boot_twilio
    RSpotify.authenticate("3a6010e0d5eb491996b9b10ec5722bae", "6b4b95f225134775a2beb8de051b55b6")
    @client = Twilio::REST::Client.new 'ACf9740b6ac694a9741c96a7a4b4adfb42', '6051d7cd115c5d52d4a61ae1e8ec083c'
  end
end
