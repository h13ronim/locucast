require 'rails_helper'

describe '/users/sign_in', :type => :request do
  subject { post request_url, query }

  let(:request_url) { "/users/sign_in/" }
  let(:query) do
    {
      "user" => {
        "email"=>user.email,
        "password"=>user.password,
      }
    }
  end
  let(:user) { create(:user) }

  context "when credentials are valid" do
    it "redirects to uploads/index action" do
      subject

      expect(response).to redirect_to(audiobooks_path)
    end
  end

  context "when there is stored location for given user" do
    #TODO: write test for ths
    #it "redirects to stored location" do
    #end
  end
end
