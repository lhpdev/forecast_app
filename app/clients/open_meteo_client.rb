# Fetches weather forecasts for a coordinate using Open-Meteo.
class OpenMeteoClient < ApiClient
  BASE_URL = "https://api.open-meteo.com/v1/forecast".freeze

  def forecast_for(location)
    payload = get_json(
      BASE_URL,
      latitude: location.latitude,
      longitude: location.longitude,
      current: "temperature_2m",
      daily: "temperature_2m_max,temperature_2m_min",
      timezone: "auto",
      forecast_days: 1
    )

    Forecast.from_open_meteo(payload)
  rescue KeyError, NoMethodError => e
    raise Error, "Unexpected Open-Meteo payload: #{e.message}"
  end
end
