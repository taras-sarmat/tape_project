require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'POST send_sms' do
    
    it "Should response with a successful 200 response when data is valid" do
      post(:send_sms, params: { :number => "+380967625151", :artist => "Justin Bieber"})
      expect(response).to be_success
    end

    it "Should response with a status 404 when artist doesn't exist" do
      post(:send_sms, params: {  :format => 'json', :number => "+380967625151", :artist => "ivo bobul"})
      expect(response.status).to eq(404)
    end

    it "Should response with a status 400 when number is invalid and artist exists" do
      post(:send_sms, params: {  :format => 'json', :number => "+12312", :artist => "Justin Bieber"})
      expect(response.status).to eq(400)
    end
  end
end
