require 'rails_helper'

describe '/audiobooks/update', type: :request do
  subject { put request_url, query }

  let(:request_url) { "/audiobooks/#{upload_id}" }
  let(:upload_id) { 1 }
  let(:query) { {} }

  context 'when unauthenticated' do
    before { subject }

    it 'redirects to login form' do
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'when authenticated' do
    let(:user) { create(:user) }
    let(:upload) { create(:upload, user: user) }
    let(:upload_id) { upload.id }

    before do
      login_as(user, scope: :user)
    end

    context 'when update succeeds' do
      let(:query) do
        {
          "upload" => {
            "uploaded_files_order" => uploaded_files_order,
            "picture_url" => picture_url
          }
        }
      end
      let(:uploaded_files_order) { [5, 6, 7, 8] }
      let(:picture_url) { "http://test.com/picture/1" }

      it 'redirects to show action' do
        subject

        expect(response).to redirect_to(audiobook_path(upload))
      end

      it "updates Upload#uploaded_files_order" do
        expect { subject }.to change { upload.reload.uploaded_files_order }.to(uploaded_files_order)
      end

      it "updates Upload#picture_url" do
        expect { subject }.to change { upload.reload.picture_url }.to(picture_url)
      end
    end

    context 'when update fails' do
      let(:query) do
        { "upload" => { "name"=> '' } }
      end

      it 'renders edit action' do
        expect(subject).to render_template(:edit)
      end
    end
  end
end
