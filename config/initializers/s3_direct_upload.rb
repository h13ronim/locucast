S3DirectUpload.config do |c|
  c.access_key_id = ENV['AWS_ACCESS_KEY']       # your access key id
  c.secret_access_key = ENV['AWS_SECRET_KEY']   # your secret access key
  c.bucket = ENV['AWS_S3_BUCKET']               # your bucket name
  c.region = ENV['AWS_S3_REGION']               # region prefix of your bucket url. This is _required_ for the non-default AWS region, eg. "s3-eu-west-1"
  c.url = ENV['AWS_S3_URL']                     # S3 API endpoint (optional), eg. "https://#{c.bucket}.s3.amazonaws.com/"
end
