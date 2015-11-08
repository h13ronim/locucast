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
      let(:uploaded_files_ordered) { double('uploaded_files_ordered') }

      before do
        allow_any_instance_of(Upload).to receive(:uploaded_files_ordered) { uploaded_files_ordered }
      end

      it "returns 200 response code" do
        subject

        expect(response.code.to_i).to eq(200)
      end

      it 'assigns @upload' do
        subject

        expect(assigns[:upload]).to eq(upload)
      end

      it 'assigns @uploaded_files' do
        subject

        expect(assigns[:uploaded_files]).to eq(uploaded_files_ordered)
      end

      context "and there is show_success_upload_flash param set to true passed" do
        let(:uploaded_file) { create(:uploaded_file, user: user) }
        let(:request_url) { "/uploads/#{upload_id}?show_success_upload_flash=true" }

        it "returns flash message" do
          subject

          expect(flash[:notice]).to eq("All files uploaded.")
        end
      end
    end
  end
end

