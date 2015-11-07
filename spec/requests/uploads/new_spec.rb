require 'rails_helper'

describe '/uploads/new', :type => :request do
  let(:request_url) { '/uploads/new' }

  context 'when unauthenticated' do
    before { get request_url }

    it 'redirects to login form' do
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'when authenticated' do
    before do
      login_as(create(:user), :scope => :user)
      get request_url
    end

    it { expect(response).to be_success }
  end
end
