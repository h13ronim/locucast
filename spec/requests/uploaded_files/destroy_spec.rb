require 'rails_helper'

describe '/uploaded_files/destroy', :type => :request do
  subject { delete request_url }

  let(:request_url) { "/uploaded_files/#{uploaded_file_id}" }
  let(:uploaded_file_id) { 1 }

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
    let(:uploaded_file_id) { uploaded_file.id }
    let!(:uploaded_file) { create(:uploaded_file, upload: upload) }
    let(:upload) { create(:upload, user: user) }

    it "destroys UploadedFile" do
      expect { subject }.to change { upload.uploaded_files.reload.count }.by(-1)
    end

    it "redirects to Upload" do
      subject

      expect(response).to redirect_to(upload)
    end
  end
end

