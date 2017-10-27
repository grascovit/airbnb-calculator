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

    it 'redirects to result page after form submit', js: true do
      visit root_path

      fill_in 'long_term_income', with: '500'
      fill_in 'address', with: 'Goiânia'

      expect(page).to have_selector('.pac-item')

      find('#address').send_keys(:down)
      find('#address').send_keys(:enter)
      click_button('Calculate')

      expect(page.current_path).to eq('/calculator')
    end
  end

  describe 'result page' do
    it 'displays 3 paragraphs containing the result data', js: true do
      visit root_path

      fill_in 'long_term_income', with: '500'
      fill_in 'address', with: 'Goiânia'

      expect(page).to have_selector('.pac-item')

      find('#address').send_keys(:down)
      find('#address').send_keys(:enter)
      click_button('Calculate')

      expect(page).to have_selector('p', count: 3)
    end

    it 'displays a back to the calculator button', js: true do
      visit root_path

      fill_in 'long_term_income', with: '500'
      fill_in 'address', with: 'Goiânia'

      expect(page).to have_selector('.pac-item')

      find('#address').send_keys(:down)
      find('#address').send_keys(:enter)
      click_button('Calculate')

      expect(page).to have_link('Go back to the calculator', href: '/calculator/new')
    end

    it 'redirects to the calculator page when clicking on back button', js: true do
      visit root_path

      fill_in 'long_term_income', with: '500'
      fill_in 'address', with: 'Goiânia'

      expect(page).to have_selector('.pac-item')

      find('#address').send_keys(:down)
      find('#address').send_keys(:enter)
      click_button('Calculate')

      click_link('Go back to the calculator')

      expect(page.current_path).to eq('/calculator/new')
    end

    context 'when airbnb is more profitable' do
      it 'displays the desired result data', js: true do
        visit root_path

        fill_in 'long_term_income', with: '10'
        fill_in 'address', with: 'Goiânia'

        expect(page).to have_selector('.pac-item')

        find('#address').send_keys(:down)
        find('#address').send_keys(:enter)
        click_button('Calculate')

        expect(page).to have_css('p', text: /You could earn an average of \$\d+\.\d+ per month with Airbnb./)
        expect(page).to have_css('p', text: /You could earn \$\d+\.\d+ \(\d+.\d+%\) more than long term rent./)
        expect(page).to have_css('p', text: /It is profitable to do Airbnb./)
      end
    end

    context 'when long term rent is more profitable' do
      it 'displays the desired result data', js: true do
        visit root_path

        fill_in 'long_term_income', with: '10000'
        fill_in 'address', with: 'Goiânia'

        expect(page).to have_selector('.pac-item')

        find('#address').send_keys(:down)
        find('#address').send_keys(:enter)
        click_button('Calculate')

        expect(page).to have_css('p', text: /You could earn an average of \$\d+\.\d+ per month with Airbnb./)
        expect(page).to have_css('p', text: /You could earn \$\d+\.\d+ \(\-\d+.\d+%\) less than long term rent./)
        expect(page).to have_css('p', text: /It is not profitable to do Airbnb./)
      end
    end
  end
end
