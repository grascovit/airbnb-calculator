Rails.application.routes.draw do
  resource :calculator, only: %i[create new], controller: 'calculator'

  root to: 'calculator#new'
end
