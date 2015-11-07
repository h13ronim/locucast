FactoryGirl.define do
  factory :uploaded_file do
    upload
    # we may actually use that as we use open()
    url Rails.root.join('spec/fixtures/1984-01_64kb.mp3')
  end
end
