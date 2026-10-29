class Search
  include HTTParty

  NOMINATIM_BASE_URL = 'https://nominatim.openstreetmap.org/search'
  FORECAST_BASE_URL = 'https://api.open-meteo.com/v1/forecast?'

  def initialize(q)
    @q = q
    @lat, @lon, @timezone= fetch_address(@q)
    @forecast_params = build_forecast_params(@lat, @lon)
  end

  def fetch_forecast
    return unless @forecast_params

    response = self.class.get(
      FORECAST_BASE_URL + "#{@forecast_params}",
      headers: { 'User-Agent' => 'forecast_app/1.0 (+https://github.com/lhpdev/forecast_app)' }
    )
    Forecast.new(response, @q).parse
  end

  private

  def build_forecast_params(lat, lon)
    return unless lat.present? & lon.present?

    "latitude=#{lat}&longitude=#{lon}&daily=temperature_2m_max,temperature_2m_min&current=temperature_2m&timezone=America%2FNew_York&forecast_days=1"
  end

  def fetch_address(q)
    return unless q

    response = self.class.get(
      NOMINATIM_BASE_URL,
      query: { q: q, format: 'json', limit: 1 },
      headers: { 'User-Agent' => 'forecast_app/1.0 (+https://github.com/lhpdev/forecast_app)' }
    )

    lat, lon = response.first['lat'], response.first['lon']
  end
end