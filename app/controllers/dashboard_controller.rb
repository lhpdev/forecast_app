class DashboardController < ApplicationController
  def index
  end

  def search
    result = Search.new(q_params).fetch_forecast
    render 'dashboard/forecast', locals: { result: result }
  end

  private

  def q_params
    params.expect(:q)
  end
end
