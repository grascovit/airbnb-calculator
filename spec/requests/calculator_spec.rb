require 'rails_helper'

RSpec.describe 'Calculator', type: :request do
  describe 'GET #new' do
    it 'returns 200 as http status' do
      get new_calculator_path

      expect(response).to have_http_status(:ok)
    end
  end
end
