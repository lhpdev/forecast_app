class DashboardController < ApplicationController
  def index
  end

  def search
    result = Search.new.fetch(zipcode_search_params)
    render 'dashboard/forecast', locals: { result: result }
  end

  private

  def zipcode_search_params
    params.expect(:zipcode)
  end
end
