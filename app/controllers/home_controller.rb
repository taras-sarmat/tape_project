class HomeController < ApplicationController
  def index
  end

  def send_sms
    users_phone = params[:user][:telephone]
    artist = params[:artist][:name]
    boot_twilio

    artist = RSpotify::Artist.search(artist).first
    track = artist.top_tracks(:US).first
    body = "#{artist.name}'s top track: #{track.name}"
    begin
      sms = @client.messages.create(
        from: '+12676898582',
        to: users_phone,
        body: body
      )
    rescue Twilio::REST::RestException => e
      print e.message
    end
  end

  private

  def boot_twilio
    RSpotify.authenticate("3a6010e0d5eb491996b9b10ec5722bae", "6b4b95f225134775a2beb8de051b55b6")
    @client = Twilio::REST::Client.new 'AC64d8478d2a10c578da81a308acaea13c', '06ec3258a72067e7bca5c55ccc3cdf87'
  end

end

# RSpotify.authenticate("3a6010e0d5eb491996b9b10ec5722bae", "6b4b95f225134775a2beb8de051b55b6")

# artist = RSpotify::Artist.search("Justin Bieber").first
# track = artist.top_tracks(:US).first

# body = "#{artist.name}'s top track: #{track.name}"

# @client = Twilio::REST::Client.new 'AC64d8478d2a10c578da81a308acaea13c', '06ec3258a72067e7bca5c55ccc3cdf87'

# TEST_PHONE_NUMBER = '+380685424117'
# @client.api.account.messages.create({
#   from: '+12676898582',
#   to: ENV['TEST_PHONE_NUMBER'],
#   body: body,
# })

# puts "Texted #{ENV['TEST_PHONE_NUMBER']}"
