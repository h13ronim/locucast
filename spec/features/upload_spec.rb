require 'rails_helper'

describe 'upload', :type => :feature do
  it 'renders view', js: true do
    login_as(create(:user), :scope => :user)
    visit '/uploads/new'
    expect(page).to have_content('Upload your files')
    # TODO: WIP in other pair
    # fill_in('Name', with: 'my audiobook')
    # fill_in('Description', with: 'my new audiobook')
    # TODO: add multiple files
    #expect {
      #expect {
        #click_button('Create Upload')
      #}.to change(Upload, :count).by(1)
    #}.to change(UploadedFile, :count).by(3)
  end
end
