require "rails_helper"

RSpec.describe "Dashboard", type: :request do
  describe "POST /dashboard/search" do
    it "renders the forecast", vcr: { cassette_name: "dashboard/search" } do
      post dashboard_search_path, params: { q: "95014" }, as: :turbo_stream

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Cupertino", "Current temperature", "°C")
      expect(response.body).to include("weather/mild", "Mild weather") # 12.3°C in the cassette
      expect(response.body).not_to include("Served from cache")
    end

    it "tells the user when the forecast came from cache", vcr: { cassette_name: "dashboard/search_cached" } do
      allow(Rails).to receive(:cache).and_return(ActiveSupport::Cache::MemoryStore.new)

      2.times { post dashboard_search_path, params: { q: "95014" }, as: :turbo_stream }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Served from cache")
    end

    it "shows a friendly message when the address is unknown", vcr: { cassette_name: "dashboard/not_found" } do
      post dashboard_search_path, params: { q: "qwxzv nowhere 000" }, as: :turbo_stream

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include("couldn&#39;t find that address")
    end

    it "shows a friendly message when an upstream API fails" do
      stub_request(:get, /#{NominatimClient::BASE_URL}/o).to_return(status: 503)

      post dashboard_search_path, params: { q: "95014" }

      expect(response).to have_http_status(:bad_gateway)
      expect(response.body).to include("weather service is unavailable")
    end
  end
end
