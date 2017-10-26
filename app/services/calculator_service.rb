class CalculatorService
  def initialize(long_term_income, airbnb_income)
    @long_term_income = long_term_income
    @airbnb_income = airbnb_income
  end

  def call
    delta = @airbnb_income - @long_term_income
    percentage = (delta / @long_term_income) * 100

    {
      airbnb_income: @airbnb_income.round(2),
      percentage: percentage.round(2),
      delta: delta.round(2),
      profitable: delta > 0
    }
  end
end
