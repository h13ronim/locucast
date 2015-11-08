require_relative 'vcr_sensitive_data'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.ignore_localhost = true
  config.allow_http_connections_when_no_cassette = ENV['VCR_PASS'].present?
  config.filter_sensitive_data('Bearer <OAUTH_TOKEN>') do |interaction|
    if interaction.request.headers['Authorization']
      interaction.request.headers['Authorization'].first
    end
  end

  VcrSensitiveData.new.each do |sensitive_replacement, sensitive_value|
    config.filter_sensitive_data(sensitive_replacement) { sensitive_value }
  end

  config.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end
end
