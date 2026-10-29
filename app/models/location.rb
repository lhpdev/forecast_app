Location = Data.define(:latitude, :longitude, :name, :postal_code, :country_code) do
  # Forecasts are cached per zip code. Some places have no zip code (e.g. a
  # search for a whole country), so we fall back to the coordinates.
  def cache_key
    postal_code || "#{latitude},#{longitude}"
  end
end
