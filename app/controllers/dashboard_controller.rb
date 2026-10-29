class DashboardController < ApplicationController
  def index
  end

  def search
    result = Search.new(q_params).fetch_forecast

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("forecast_result", partial: "dashboard/forecast", locals: { result: result })
      end
      format.html { render 'dashboard/forecast', locals: { result: result } }
    end
  end

  private

  def q_params
    params.expect(:q)
  end
end
