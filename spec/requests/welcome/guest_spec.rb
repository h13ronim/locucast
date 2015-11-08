require 'rails_helper'

describe '/guest', type: :request do
  subject { post request_url, query }

  let(:request_url) { "/guest" }
  let(:query) do
    {
      "user" => {
        "email"=>guest.email,
      }
    }
  end
  let(:guest) { create(:guest_user) }

  context "when credentials are valid" do
    it "redirects to uploads/index action" do
      subject

      expect(response).to redirect_to(uploads_path)
    end
  end
end

