require 'rails_helper'

describe 'welcome', :type => :feature do
  it 'renders view' do
    visit '/'
    expect(page).to have_content('Hello, Locutus :)')
  end
end