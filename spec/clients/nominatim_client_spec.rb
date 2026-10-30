require "rails_helper"

RSpec.describe NominatimClient do
  subject(:client) { described_class.new }

  context "when the address is found", vcr: { cassette_name: "nominatim/found" } do
    it "returns the location" do
      expect(client.locate("95014")).to have_attributes(
        latitude: be_within(0.1).of(37.32), longitude: be_within(0.1).of(-122.03),
        name: include("Cupertino"), postal_code: "95014", country_code: "us"
      )
    end
  end

  context "when nothing matches", vcr: { cassette_name: "nominatim/not_found" } do
    it { expect(client.locate("qwxzv nowhere 000")).to be_nil }
  end

  context "when the address is blank" do
    it "does not hit the API" do
      expect(client.locate("")).to be_nil
      expect(a_request(:get, /nominatim/)).not_to have_been_made
    end
  end

  context "when the API fails" do
    before { stub_request(:get, /#{described_class::BASE_URL}/o).to_return(status: 503) }

    it { expect { client.locate("95014") }.to raise_error(ApiClient::Error, /HTTP 503/) }
  end

  context "when the request times out" do
    before { stub_request(:get, /#{described_class::BASE_URL}/o).to_timeout }

    it { expect { client.locate("95014") }.to raise_error(ApiClient::Error) }
  end
end
