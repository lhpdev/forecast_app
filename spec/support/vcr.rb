require "vcr"
require "webmock/rspec"

# Real API responses are recorded once into spec/fixtures/vcr_cassettes and
# replayed afterwards. Delete a cassette to re-record it against the live API.
VCR.configure do |config|
  config.cassette_library_dir = Rails.root.join("spec/fixtures/vcr_cassettes")
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.default_cassette_options = { record: :once, match_requests_on: %i[method uri] }
end
