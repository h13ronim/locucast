RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :request
  config.include Warden::Test::Helpers, type: :feature
  config.before :suite do
    Warden.test_mode!
  end
end
