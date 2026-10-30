require "rails_helper"

RSpec.describe ForecastSearch do
  subject(:search) { described_class.new(cache:) }

  let(:cache) { ActiveSupport::Cache::MemoryStore.new }
  let(:weather_requests) { a_request(:get, /#{OpenMeteoClient::BASE_URL}/o) }

  it "returns a fresh forecast for the geocoded location", vcr: { cassette_name: "forecast_search/zip_code" } do
    result = search.call("  95014 ")

    expect(result).to have_attributes(query: "95014", cached?: false)
    expect(result.location).to have_attributes(postal_code: "95014", country_code: "us")
    expect(result.forecast.current_temperature).to be_a(Numeric)
  end

  it "serves subsequent searches for the same zip code from cache",
     vcr: { cassette_name: "forecast_search/same_zip_code" } do
    search.call("95014")
    result = search.call("1 Infinite Loop, Cupertino, CA 95014")

    expect(weather_requests).to have_been_made.once
    expect(result).to be_cached
  end

  it "expires the cache after 30 minutes",
     vcr: { cassette_name: "forecast_search/cache_expiry" } do
    search.call("95014")

    travel(31.minutes) { expect(search.call("95014")).not_to be_cached }
    expect(weather_requests).to have_been_made.twice
  end

  it "raises LocationNotFound when the address can't be geocoded",
     vcr: { cassette_name: "forecast_search/not_found" } do
    expect { search.call("qwxzv nowhere 000") }.to raise_error(ForecastSearch::LocationNotFound)
    expect(weather_requests).not_to have_been_made
  end
end
