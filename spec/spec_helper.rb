require 'bundler/setup'
require 'nextcloud-ruby'

require 'support/vcr'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

require 'simplecov'
SimpleCov.start

RSpec.configure do |config|
  config.before(:each) do
    Nextcloud::Ruby.configure do |configuration|
      configuration.dav_url = 'https://demo12.nextcloud.bayton.org/remote.php/dav/'
      configuration.username = 'admin'
      configuration.password = 'admin'
    end
  end
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
