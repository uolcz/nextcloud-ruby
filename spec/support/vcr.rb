require 'webmock/rspec'
require 'vcr'

WebMock.allow_net_connect!

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr'
  config.hook_into :webmock
  config.before_record { |i| i.response.body.force_encoding 'UTF-8' }
  config.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: %i[method uri]
  }
  config.before_record do |i|
    i.request.headers.clear
    save_headers = %w[Total Per-Page Link Content-Type Content-Length]
    i.response.headers.select! { |key| save_headers.include? key }
  end
end

WebMock.disable_net_connect!(allow_localhost: true)
