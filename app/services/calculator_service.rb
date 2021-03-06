class CalculatorService
  def initialize(long_term_income, airbnb_income)
    @long_term_income = long_term_income.to_f
    @airbnb_income = airbnb_income.to_f
  end

  def call
    delta = @airbnb_income - @long_term_income
    percentage = (delta / (@long_term_income.nonzero? || 1)) * 100

    {
      airbnb_income: @airbnb_income.round(2),
      percentage: percentage.round(2),
      delta: delta.round(2).abs,
      profitable: delta > 0
    }
  end
end
