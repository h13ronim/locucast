require 'rails_helper'

describe '/uploads/destroy', :type => :request do
  subject { delete request_url }

  let(:request_url) { "/audiobooks/#{upload_id}" }
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
    let(:upload_id) { upload.id }
    let!(:upload) { create(:upload, user: user) }

    context "when deletion succeeds" do
      it "destroys Upload" do
        expect { subject }.to change { user.uploads.reload.count }.by(-1)
      end

      it "redirects to index action" do
        subject

        expect(response).to redirect_to(audiobooks_path)
      end

      it "sets flash[:notice]" do
        subject

        expect(flash[:notice]).to eq("Audiobook successfully deleted.")
      end
    end

    context "when deletion fails" do
      before { allow_any_instance_of(Upload).to receive(:destroy) { false } }

      it "sets flash[:error]" do
        subject

        expect(flash[:error]).to eq("Audiobook deletion failed.")
      end

      it "redirects to :index action" do
        subject

        expect(response).to redirect_to(audiobooks_path)
      end
    end
  end
end

