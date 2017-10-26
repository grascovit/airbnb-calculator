require 'rails_helper'

RSpec.describe AirbnbScrapeService do
  describe '#call' do
    context 'with valid params' do
      it 'returns a float as average income for the coordinates' do
        average_income = described_class.new('-16.684677', '-49.265236').call

        expect(average_income).to be_a(Float)
      end
    end

    context 'with invalid params' do
      it 'returns a float as average income for the current IP location' do
        average_income = described_class.new(nil, nil).call

        expect(average_income).to be_a(Float)
      end
    end
  end
end
