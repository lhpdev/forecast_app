# Resolves an address to a location and returns its forecast, cached per zip code.
#
#   result = ForecastSearch.call("Cupertino, CA")
#   result.forecast.current_temperature # => 18.4
#   result.cached?                      # => false
class ForecastSearch
  CACHE_TTL = 30.minutes

  class LocationNotFound < StandardError; end

  Result = Data.define(:query, :location, :forecast, :cached) do
    alias_method :cached?, :cached
  end

  def self.call(query)
    new.call(query)
  end

  def initialize(geocoder: NominatimClient.new, weather: OpenMeteoClient.new, cache: Rails.cache)
    @geocoder = geocoder
    @weather = weather
    @cache = cache
  end

  def call(query)
    query = query.to_s.strip
    location = @geocoder.locate(query) or raise LocationNotFound, "No location found for #{query.inspect}"

    cached = true
    forecast = @cache.fetch("forecast/#{location.cache_key}", expires_in: CACHE_TTL) do
      cached = false
      @weather.forecast_for(location)
    end

    Result.new(query:, location:, forecast:, cached:)
  end
end
