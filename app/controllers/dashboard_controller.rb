class DashboardController < ApplicationController
  def index
  end

  def search
    render_forecast(result: ForecastSearch.call(q_params))
  rescue ForecastSearch::LocationNotFound
    render_forecast(error: "We couldn't find that address. Try a zip code or a city name.", status: :not_found)
  rescue ApiClient::Error => e
    Rails.logger.error("[ForecastSearch] #{e.message}")
    render_forecast(error: "The weather service is unavailable right now. Please try again later.", status: :bad_gateway)
  end

  private

  def render_forecast(result: nil, error: nil, status: :ok)
    locals = { result:, error: }

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("forecast_result", partial: "dashboard/forecast", locals:), status:
      end
      format.html { render "dashboard/forecast", locals:, status: }
    end
  end

  private

  def q_params
    params.expect(:q)
  end
end
