FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@example.com"
    end
    password              'password'
    password_confirmation 'password'

    trait :guest do
      to_create {|instance| instance.save(validate: false) }
      password              ''
      password_confirmation ''
    end
  end

  factory :guest_user, traits: [:guest], parent: :user
end
