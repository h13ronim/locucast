FactoryGirl.define do
  factory :upload do
    user
    sequence :name do |n|
      "Upload #{n}"
    end
    sequence :description do |n|
      "Upload description #{n}"
    end
    token 'diej1eb1zee7rae3chahzaiK7uecho6pe6tu6rohr5Faighiaro4megiphah7Eif'
    picture_url 'http://example.com/picture.jpg'
  end
end
