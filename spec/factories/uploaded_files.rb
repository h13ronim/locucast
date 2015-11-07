FactoryGirl.define do
  factory :uploaded_file do
    upload
    url 'TODO: add url to real file in S3 bucket'
  end
end
