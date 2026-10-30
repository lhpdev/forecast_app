require "rails_helper"

RSpec.describe OpenMeteoClient do
  subject(:client) { described_class.new }

  let(:location) do
    Location.new(latitude: 40.75, longitude: -73.99, name: "New York", postal_code: "10001", country_code: "us")
  end

  context "with a valid payload", vcr: { cassette_name: "open_meteo/forecast" } do
    it "returns the forecast" do
      expect(client.forecast_for(location)).to have_attributes(
        current_temperature: be_a(Numeric), max_temperature: be_a(Numeric), min_temperature: be_a(Numeric),
        unit: "°C", timezone: "America/New_York"
      )
    end

    it "queries by the location's coordinates" do
      client.forecast_for(location)

      expect(a_request(:get, described_class::BASE_URL).with(query: hash_including(latitude: "40.75", longitude: "-73.99")))
        .to have_been_made
    end
  end

  context "with invalid coordinates", vcr: { cassette_name: "open_meteo/invalid_coordinates" } do
    let(:location) { super().with(latitude: 200) }

    it { expect { client.forecast_for(location) }.to raise_error(ApiClient::Error, /HTTP 400/) }
  end

  context "with an unexpected payload" do
    before do
      stub_request(:get, /#{described_class::BASE_URL}/o)
        .to_return(status: 200, body: { error: true }.to_json, headers: { "Content-Type" => "application/json" })
    end

    it { expect { client.forecast_for(location) }.to raise_error(ApiClient::Error, /Unexpected/) }
  end
end
