class CalculatorController < ApplicationController
  def new; end

  def create
    long_term_income = params[:long_term_income].to_f
    airbnb_income = AirbnbScrapeService.new(params[:latitude], params[:longitude]).call

    if airbnb_income
      @result = CalculatorService.new(long_term_income, airbnb_income).call

      render 'result'
    else
      redirect_to new_calculator_path, alert: 'There was an error when trying to fetch Airbnb data.'
    end
  end
end
