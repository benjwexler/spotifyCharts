Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'scraper#index'

  get 'index', to: 'scraper#index'

end
