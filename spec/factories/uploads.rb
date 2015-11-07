FactoryGirl.define do
  factory :upload do
    user
    sequence :name do |n|
      "Upload #{n}"
    end
    sequence :description do |n|
      "Upload description #{n}"
    end
  end
end
