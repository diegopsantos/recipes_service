# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'
ENV['CONTENTFUL_ACCESS_TOKEN'] ||= 'token-example'

require_relative '../boot'

require 'pry'
require 'vcr'
require 'webmock/rspec'
require 'rack/test'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.filter_sensitive_data('<SENSITIVE_DATA>') do
    "Bearer #{ENV['CONTENTFUL_ACCESS_TOKEN']}"
  end

  config.default_cassette_options = { record: :once }
  config.allow_http_connections_when_no_cassette = true

end