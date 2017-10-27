require 'rails_helper'

RSpec.describe CalculatorController, type: :routing do
  describe 'GET /' do
    it 'routes to #new' do
      expect(get: '/').to route_to('calculator#new')
    end
  end

  describe 'GET /calculator/new' do
    it 'routes to #new' do
      expect(get: '/calculator/new').to route_to('calculator#new')
    end
  end

  describe 'POST /calculator' do
    it 'routes to #create' do
      expect(post: '/calculator').to route_to('calculator#create')
    end
  end
end
