module CalculatorHelper
  def more_or_less(profitable)
    profitable ? 'more' : 'less'
  end

  def profitable_or_not(profitable)
    profitable ? 'is' : 'is not'
  end
end
