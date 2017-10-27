require 'rails_helper'

feature 'Calculator', type: :feature do
  describe 'root page' do
    it 'displays long term income field' do
      visit root_path

      expect(page).to have_field('long_term_income')
    end

    it 'displays address field' do
      visit root_path

      expect(page).to have_field('address')
    end

    it 'displays the address suggestion on type', js: true do
      visit root_path

      fill_in 'long_term_income', with: '500'
      fill_in 'address', with: 'Goiânia'

      expect(page).to have_selector('.pac-item')
      
      find('#address').send_keys(:down)      
      find('#address').send_keys(:enter)

      expect(page).to have_field('address', with: 'Goiânia - State of Goiás, Brazil')
    end

    skip 'sets the latitude and longitude to the hidden fields', js: true do
      visit root_path

      fill_in 'long_term_income', with: '500'
      fill_in 'address', with: 'Goiânia'

      expect(page).to have_selector('.pac-item')

      find('#address').send_keys(:down)      
      find('#address').send_keys(:enter)

      # expect(find('#latitude', visible: false).value).to eq('-16.68689119999999')
      # expect(find('#longitude', visible: false).value).to eq('-49.264794300000005')
    end
  end
end