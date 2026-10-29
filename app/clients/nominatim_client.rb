# Geocodes a free-text address (zip code, city, street...) using OpenStreetMap Nominatim.
class NominatimClient < ApiClient
  BASE_URL = "https://nominatim.openstreetmap.org/search".freeze

  # Returns a Location, or nil when the address can't be found.
  def locate(address)
    return if address.blank?

    results = get_json(BASE_URL, q: address, format: "json", limit: 1, addressdetails: 1, "accept-language": "en")
    build_location(results.first) if results.present?
  end

  private

  def build_location(result)
    address = result.fetch("address", {})

    Location.new(
      latitude: result.fetch("lat").to_f,
      longitude: result.fetch("lon").to_f,
      name: result["display_name"],
      postal_code: address["postcode"],
      country_code: address["country_code"]
    )
  end
end
