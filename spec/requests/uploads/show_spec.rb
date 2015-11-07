require 'rails_helper'

describe '/uploads/show', :type => :request do
  subject { get request_url }

  let(:request_url) { "/uploads/#{upload_id}" }
  let(:upload_id) { 1 }

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

    context "when there is Upload with given id" do
      let(:upload_id) { upload.id }
      let(:upload) { create(:upload, user: user) }

      it "returns 200 response code" do
        subject

        expect(response.code.to_i).to eq(200)
      end
    end
  end
end

