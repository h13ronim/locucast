require 'rails_helper'

describe '/audiobooks/show', :type => :request do
  subject { get request_url }

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

    context "when there is Upload with given id" do
      let(:upload_id) { upload.id }
      let(:upload) { create(:upload, user: user) }
      let!(:uploaded_file_1) { create(:uploaded_file, upload: upload) }
      let!(:uploaded_file_2) { create(:uploaded_file, upload: upload) }

      before do
        upload.update(uploaded_files_order: [uploaded_file_2.id, uploaded_file_1.id])
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

        expect(assigns[:uploaded_files]).to eq([uploaded_file_2, uploaded_file_1])
      end

      context "and there is show_success_upload_flash param set to true passed" do
        let(:request_url) { "/audiobooks/#{upload_id}?show_success_upload_flash=true" }

        it "returns flash message" do
          subject

          expect(flash[:notice]).to eq("All files uploaded.")
        end
      end

      it 'has tokenized subscribe button' do
        subject
        expect(response.body).to include(
          "<a class=\"button\" target=\"_blank\" "+
          "href=\"/feeds/#{upload.id}?token=#{upload.token}\">" +
          "Subscribe" +
          "</a>"
        )
      end
    end
  end
end
