FactoryGirl.define do
  factory :uploaded_file do
    upload
    url 'https://archive.org/download/aesop_fables_volume_one_librivox/fables_01_01_aesop_64kb.mp3'
  end
end
