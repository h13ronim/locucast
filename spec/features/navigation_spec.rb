require 'rails_helper'

describe 'navigation', :type => :feature do
  context 'when unauthenticated' do
    it 'renders welcome' do
      visit '/'
      click_link 'Locucast'
      expect(page).to have_content(
        'Listen to your books in your favorite podcast player'
      )
    end
  end

  context 'when authenticated' do
    before { login_as(create(:user), :scope => :user) }

    it 'renders audiobooks index' do
      visit '/'
      click_link 'Locucast'
      expect(page).not_to have_content(
        'Listen to your books in your favorite podcast player'
      )
    end
  end
end
