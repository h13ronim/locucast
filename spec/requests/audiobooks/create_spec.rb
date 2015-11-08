require 'rails_helper'

describe '/uploads/create', type: :request do
  let(:request_url) { '/audiobooks' }
  let(:query) do
    {
      "utf8"=>"✓",
      "authenticity_token"=>"3M6Gqmpk6w7mNF7l63OAllCMbAhNxX4sp6jxBZJ+pHkmJrXY1BY69wgbUpYFdkHeciPa9S31iE6ft84R9qip4Q==",
      "upload"=>{
        "name"=>"xx",
        "description"=>"xx",
      },
      "commit"=>"Create Upload"
    }
  end

  context 'when unauthenticated' do
    before { post request_url, query }

    it 'redirects to login form' do
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'when authenticated' do
    before do
      login_as(create(:user), scope: :user)
      post request_url, query
    end

    it { expect(response).to redirect_to(audiobook_path(assigns(:upload))) }
  end
end
