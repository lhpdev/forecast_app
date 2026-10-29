class Forecast
  def initialize(response, q)
    @response = response
    @q = q
  end

  def parse
    return unless @response

    object = {}

    object[:q] = @q
    object[:latitude] = @response['latitude']
    object[:longitude] = @response['longitude']
    object[:current_temperature] = @response['current']['temperature_2m']
    object[:max_temperature] = @response['daily']['temperature_2m_max'].first
    object[:min_temperature] = @response['daily']['temperature_2m_min'].first

    object
  end
end