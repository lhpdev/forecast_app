Forecast = Data.define(:current_temperature, :max_temperature, :min_temperature, :unit, :timezone, :fetched_at) do
  def self.from_open_meteo(payload)
    new(
      current_temperature: payload.fetch("current").fetch("temperature_2m"),
      max_temperature: payload.fetch("daily").fetch("temperature_2m_max").first,
      min_temperature: payload.fetch("daily").fetch("temperature_2m_min").first,
      unit: payload.dig("current_units", "temperature_2m") || "°C",
      timezone: payload["timezone"],
      fetched_at: Time.current
    )
  end

  def feel
    if current_temperature >= 25 then :hot
    elsif current_temperature <= 10 then :cold
    else :mild
    end
  end
end
