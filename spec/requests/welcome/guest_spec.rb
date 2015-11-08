require 'rails_helper'

describe '/guest', type: :request do
  let!(:template_user) { create(:user, email: ENV['GUEST_USER_TEMPLATE']) }
  let!(:template_user_upload) { create(:upload, user: template_user) }
  let!(:template_user_uploaded_file) do
    create(:uploaded_file, upload: template_user_upload)
  end

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
