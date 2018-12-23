Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :thermostats, only: %i(show) do
    resources :readings, only: %i(show create)
  end
end
