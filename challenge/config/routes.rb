Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :employees do
    get 'result', on: :collection, defaults: { format: :csv }
  end
end