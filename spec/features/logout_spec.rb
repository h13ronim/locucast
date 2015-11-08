require 'rails_helper'

describe 'logout', :type => :feature do
  before { login_as(create(:user), :scope => :user) }

  it 'renders audiobooks index' do
    visit '/'
    click_link 'Sign out'
    expect(page).not_to have_content(
      'Signed out successfully.'
    )
  end
end
