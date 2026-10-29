# Base class for external HTTP APIs: shared headers, timeouts and error handling.
class ApiClient
  include HTTParty

  class Error < StandardError; end

  USER_AGENT = "forecast_app/1.0 (+https://github.com/lhpdev/forecast_app)".freeze

  default_timeout 5
  headers "User-Agent" => USER_AGENT, "Accept" => "application/json"

  private

  def get_json(url, query)
    response = self.class.get(url, query: query)
    raise Error, "#{self.class.name} responded with HTTP #{response.code}" unless response.success?

    response.parsed_response
  rescue HTTParty::Error, SocketError, Timeout::Error, SystemCallError => e
    raise Error, "#{self.class.name} request failed: #{e.message}"
  end
end
