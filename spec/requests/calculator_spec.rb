require 'rails_helper'

RSpec.describe 'Calculator', type: :request do
  describe 'GET #new' do
    it 'returns 200 as http status' do
      get new_calculator_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) do
        {
          latitude: '-16.685226',
          longitude: '-49.265355',
          long_term_income: '500'
        }
      end

      it 'returns 200 as http status' do
        post calculator_path, params: valid_params

        expect(response).to have_http_status(:ok)
      end

      it 'assigns result as a hash' do
        post calculator_path, params: valid_params

        expect(assigns(:result)).to be_a(Hash)
      end

      it 'renders the result page' do
        post calculator_path, params: valid_params

        expect(response).to render_template('result')
      end
    end

    context 'with invalid params' do
      it 'returns 200 as http status' do
        post calculator_path, params: {}

        expect(response).to have_http_status(:ok)
      end

      it 'assigns result as a hash' do
        post calculator_path, params: {}

        expect(assigns(:result)).to be_a(Hash)
      end

      it 'renders the result page' do
        post calculator_path, params: {}

        expect(response).to render_template('result')
      end
    end

    context 'when airbnb scrape service fails' do
      it 'redirects to the calculator page' do
        airbnb_service = double('AirbnbScrapeService')
        allow(AirbnbScrapeService).to receive(:new).and_return(airbnb_service)
        allow(airbnb_service).to receive(:call).and_return(nil)

        post calculator_path, params: {}

        expect(response).to redirect_to(new_calculator_path)
      end
    end
  end
end
