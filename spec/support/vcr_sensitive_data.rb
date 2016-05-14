class VcrSensitiveData < Hash
  def initialize
    %w(
      GITHUB_APP_ID
      GITHUB_APP_SECRET
      AWS_ACCESS_KEY
      AWS_SECRET_KEY
      AWS_S3_BUCKET
      AWS_S3_REGION
      TOKEN_SALT
      ROLLBAR_ACCESS_TOKEN
      ROLLBAR_JS_ACCESS_TOKEN
    ).each do |sensitive_variable|
      self.merge!(sensitive_variable => ENV[sensitive_variable])
    end
  end
end
