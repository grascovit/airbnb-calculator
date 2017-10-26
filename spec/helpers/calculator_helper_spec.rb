require 'rails_helper'

RSpec.describe CalculatorHelper, type: :helper do
  describe '#more_or_less' do
    context 'when profitable param is true' do
      it "returns 'more'" do
        expect(helper.more_or_less(true)).to eq('more')
      end
    end

    context 'when profitable param is false' do
      it "returns 'less'" do
        expect(helper.more_or_less(false)).to eq('less')
      end
    end
  end

  describe '#profitable_or_not' do
    context 'when profitable param is true' do
      it "returns 'is'" do
        expect(helper.profitable_or_not(true)).to eq('is')
      end

      it "returns 'is not'" do
        expect(helper.profitable_or_not(false)).to eq('is not')
      end
    end
  end
end
