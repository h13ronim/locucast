require 'rails_helper'

describe '/uploads/update', type: :request do
  subject { put request_url, query }

  let(:request_url) { "/uploads/#{upload_id}" }
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
      let(:query) { { "upload" => { "uploaded_files_order" => uploaded_files_order } } }
      let(:uploaded_files_order) { [5, 6, 7, 8] }

      it 'redirects to show action' do
        subject

        expect(response).to redirect_to(upload_path(upload))
      end

      it "updates Upload#uploaded_files_order" do
        expect { subject }.to change { upload.reload.uploaded_files_order }.to(uploaded_files_order)
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
