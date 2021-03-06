require 'rails_helper'

RSpec.describe CalculatorService do
  describe '#call' do
    context 'when airbnb is more profitable' do
      it 'returns a hash with the result' do
        long_term_income = 1000.0
        airbnb_income = 1200.0
        service = described_class.new(long_term_income, airbnb_income)
        result = {
          airbnb_income: airbnb_income,
          percentage: 20.0,
          delta: 200.0,
          profitable: true
        }

        expect(service.call).to eq(result)
      end
    end

    context 'when long term rent is more profitable' do
      it 'returns a hash with the result' do
        long_term_income = 600.0
        airbnb_income = 500.0
        service = described_class.new(long_term_income, airbnb_income)
        result = {
          airbnb_income: airbnb_income,
          percentage: -16.67,
          delta: 100.0,
          profitable: false
        }

        expect(service.call).to eq(result)
      end
    end

    context 'when airbnb income is zero' do
      it 'returns the result with no problems' do
        long_term_income = 100.0
        airbnb_income = 0.0
        service = described_class.new(long_term_income, airbnb_income)
        result = {
          airbnb_income: airbnb_income,
          percentage: -100.0,
          delta: 100.0,
          profitable: false
        }

        expect(service.call).to eq(result)
      end
    end

    context 'when long term rent is zero' do
      it 'returns the result with no problems' do
        long_term_income = 0.0
        airbnb_income = 100.0
        service = described_class.new(long_term_income, airbnb_income)
        result = {
          airbnb_income: airbnb_income,
          percentage: 10_000.0,
          delta: 100.0,
          profitable: true
        }

        expect(service.call).to eq(result)
      end
    end

    context 'when both incomes are zero' do
      it 'returns the result with no problems' do
        long_term_income = 0.0
        airbnb_income = 0.0
        service = described_class.new(long_term_income, airbnb_income)
        result = {
          airbnb_income: airbnb_income,
          percentage: 0.0,
          delta: 0.0,
          profitable: false
        }

        expect(service.call).to eq(result)
      end
    end
  end
end
