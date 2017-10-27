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

    it 'sets the latitude and longitude to the hidden fields', js: true do
      visit root_path

      fill_in 'long_term_income', with: '500'
      fill_in 'address', with: 'Goiânia'

      expect(page).to have_selector('.pac-item')

      find('#address').send_keys(:down)      
      find('#address').send_keys(:enter)

      expect(page).to have_selector("#latitude[value='-16.68689119999999']", visible: false)
      expect(page).to have_selector("#longitude[value='-49.264794300000005']", visible: false)
    end
  end
end