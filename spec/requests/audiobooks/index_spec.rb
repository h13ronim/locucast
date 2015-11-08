require 'rails_helper'

describe '/audiobooks', :type => :request do
  subject { get request_url }

  let(:request_url) { "/audiobooks" }

  context 'when unauthenticated' do
    before { subject }

    it 'redirects to login form' do
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'when authenticated' do
    before do
      login_as(user, :scope => :user)
    end

    let(:user) { create(:user) }

    let(:upload_id) { upload.id }
    let(:upload) { create(:upload, user: user) }
    let!(:uploaded_file_1) { create(:uploaded_file, upload: upload) }
    let!(:uploaded_file_2) { create(:uploaded_file, upload: upload) }

    it "returns 200 response code" do
      subject
      expect(response.code.to_i).to eq(200)
    end

    it 'has tokenized subscribe link' do
      subject
      expect(response.body).to include(
        "<a href=\"/feeds/#{upload.id}?token=#{upload.token}\">Subscribe</a>"
      )
    end
  end
end
